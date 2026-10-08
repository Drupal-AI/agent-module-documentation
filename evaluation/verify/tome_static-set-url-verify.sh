#!/usr/bin/env bash
# Execution VERIFY: PASS when tome_static.url state equals the required URL exactly. exit 0/1.
set -uo pipefail
cd /var/www/html
want="https://tome-static-prod.example.com"
got=$(drush sget tome_static.url --format=string 2>/dev/null | tr -d '[:space:]')
if [ "$got" = "$want" ]; then echo "PASS tome_static.url=$got"; exit 0
else echo "FAIL tome_static.url=$got want=$want"; exit 1; fi
