root=$(pwd)

cd irma_keyshare_server

docker-compose up

cd $root

irma server -v --static-path "$root/irma/irmajs/examples/browser"