#!/bin/bash

set -eu

source config.sh

echo "Cleaning up worker"
curl --silent --fail -X DELETE "https://api.cloudflare.com/client/v4/accounts/$CF_ACCOUNT_ID/workers/scripts/$CF_WORKER_NAME" \
    -H "Authorization: Bearer $CF_API_TOKEN"

echo "Stop ngrok and notification listener"
kill $(cat ngrok.pid) $(cat cargo.pid)

echo "Cleaned up successfully!"
