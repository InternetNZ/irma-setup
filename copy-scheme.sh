#!/bin/bash
# Initial script to copy our custom scheme. Should be improved.
set -x

TMP_CFG=/tmp/irma_configuration
TMP_DEMO="$TMP_CFG/inz-demo"

mkdir -p ${TMP_CFG}
cp -vr ../inz-demo/ /tmp/irma_configuration
rm -rf /tmp/irma_configuration/inz-demo/.git
rm -rf /tmp/irma_configuration/inz-demo/.idea
cp -vr /tmp/irma_configuration/inz-demo/ ../irma_mobile/irma_configuration
cp -vr /tmp/irma_configuration/inz-demo/ ../irma_keyshare_server/src/main/resources/irma_configuration
cp -vr /tmp/irma_configuration/inz-demo/ $HOME/.local/share/irma/irma_configuration
