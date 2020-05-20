#!/bin/bash

set -euo pipefail

source config.sh

echo "Starting notification listener"
cargo run &
echo $! > cargo.pid

echo "Starting ngrok"
rm ngrok.log
ngrok http 7878 --log ngrok.log > /dev/null &
echo $! > ngrok.pid
sleep 5 # Hopefully ngrok has started up by now
NGROK_URL=$(grep -o -m 1 "https://[a-z0-9]*\.ngrok\.io" ngrok.log)

echo "Uploading worker and creating route in Cloudflare"
sed "s;PING_ME;$NGROK_URL/;" worker.js | curl --fail -X PUT "https://api.cloudflare.com/client/v4/accounts/$CF_ACCOUNT_ID/workers/scripts/$CF_WORKER_NAME" \
    -H "Authorization: Bearer $CF_API_TOKEN" \
    -H "Content-Type: application/javascript" \
    --data-binary @-
curl --fail "https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/workers/routes" \
    -H "Authorization: Bearer $CF_API_TOKEN" \
    -H "Content-Type: application/json" \
    --data "{
        \"pattern\": \"$CF_WORKER_ROUTE\",
        \"script\": \"$CF_WORKER_NAME\"
    }"

echo "Running in background! To stop, run stop.sh"
