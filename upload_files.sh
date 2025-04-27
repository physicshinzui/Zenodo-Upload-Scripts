#!/bin/bash
set -eu 

cat<<EOF 
Usage: 
    bash ${0} [PATH_TO_YOUR_LARGE_FILE]

EOF

YOUR_ACCESS_TOKEN=$(cat token.txt)
BUCKET_URL=$(cat draft.json | jq -r '.links.bucket')
PATH_TO_YOUR_LARGE_FILE=$1
OUTNAME=$(basename ${PATH_TO_YOUR_LARGE_FILE})

curl --progress-bar -o /dev/null \
     -H "Authorization: Bearer ${YOUR_ACCESS_TOKEN}" \
     -X PUT \
     --upload-file "${PATH_TO_YOUR_LARGE_FILE}" \
     "${BUCKET_URL}/${OUTNAME}"
