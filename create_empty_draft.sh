#!/bin/bash
set -eu 

if [ ! -e 'token.txt' ]; then 
    echo 'ERROR: token.txt posessing your token does not exist. Create it '
    exit
fi
YOUR_ACCESS_TOKEN=$(cat token.txt)

curl -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${YOUR_ACCESS_TOKEN}" \
     -X POST \
     -d '{}' \
     https://zenodo.org/api/deposit/depositions > draft.json
