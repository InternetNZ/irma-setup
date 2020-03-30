root=$(pwd)

if [ -d "irma_keyshare_server" ]; then
  cd irma_keyshare_server
  docker-compose stop
  docker-compose rm
fi

cd $root

delete="irma_configuration irma_keyshare_server irma_mobile"

rm -rf $delete 2>/dev/null
