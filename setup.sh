# GNU grep will be available using `ggrep`
brew install grep yarn go dep openssl

root=$(pwd)

schemes=(pbdf irma-demo)

# Start setting up irmago
echo "Setting up irmago"
go get -u github.com/privacybydesign/irmago/irma

cd "$GOPATH/src/github.com/privacybydesign/irmago/" || exit
dep ensure
go install ./irma

# End setting up irmago


# Start setting up irma_keyshare_server
echo "Setting up irma_keyshare_server"
cd "$root"
git clone --recursive https://github.com/robbyronk/irma_keyshare_server.git
mkdir irma_configuration
for scheme in ${schemes[*]}; do
	git clone --recursive "https://github.com/privacybydesign/${scheme}-schememanager.git" "irma_configuration/$scheme"
done

cd "$root/irma_keyshare_server/src/main/resources"

../../../utils/keygen.sh

ln -s "$root/irma_configuration" .


cp config.sample.json config.json

cp "$root/irma_api_server/src/main/resources/pk.der" ./apiserver.der

cp database.sample.xml database.xml
sed -i '' -e 's/127.0.0.1/db/' database.xml

for scheme in ${schemes[*]}; do
	cp "$root/irma_keyshare_server/src/main/resources/pk.pem" "$root/irma_configuration/$scheme/kss-0.pem"
done

echo "Generating single Idemix keypair for all issuers"
irma genkeypair -a 16 -l 1024 -p "$root/idemix_pubkey.xml" -k "$root/idemix_privkey.xml" -v 10y

for scheme in ${schemes[*]}; do
  cd "$root/irma_configuration/$scheme"

  rm index index.sig pk.pem sk.pem 2>/dev/null
  find */PublicKeys */PrivateKeys -type f -exec rm "{}" \; 2>/dev/null
  sed -i '' -E 's#<KeyshareServer>.*</KeyshareServer>#<KeyshareServer>http://localhost:8080/irma_keyshare_server/api/v1</KeyshareServer>#' description.xml

  issuer_description_paths=($(find . -mindepth 2 -maxdepth 2 -type f -name description.xml))
  for issuer_description_path in ${issuer_description_paths[*]}; do
    issuer=$(echo "$issuer_description_path" | ggrep -oP "(?<=\.\/)(.*)(?=\/)")

    mkdir -p "$issuer/PrivateKeys"

    cp "$root/idemix_pubkey.xml" "$issuer/PublicKeys/0.xml"
    cp "$root/idemix_privkey.xml" "$issuer/PrivateKeys/0.xml"
  done

  irma scheme keygen
  irma scheme sign sk.pem .
done
# End setting up irma_keyshare_server


# Start setting up irma_mobile
echo "Setting up irma_mobile"
cd "$root"
git clone https://github.com/privacybydesign/irma_mobile.git
cd "irma_mobile"

# fsevents in the lockfile is too old so we must rm the lock
rm yarn.lock

echo "Installing IRMA mobile dependencies"
yarn --silent



# End setting up irma_mobile


