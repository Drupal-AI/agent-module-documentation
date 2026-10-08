#!/usr/bin/env bash
# HARD VERIFY: PASS when stripe.settings apikey.test.webhook == whsec_TASK_secret. exit 0/1.
set -uo pipefail
cd /var/www/html
wh=$(drush config:get stripe.settings apikey.test.webhook --format=string 2>/dev/null)
if [ "$wh" = "whsec_TASK_secret" ]; then echo "PASS webhook=$wh"; exit 0; else echo "FAIL webhook=$wh"; exit 1; fi
