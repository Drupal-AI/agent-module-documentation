#!/usr/bin/env bash
# Execution RESET: clear the publisher ID so the adsense_adstxt controller returns 404 and verify
# FAILS until the agent configures the publisher ID. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_basic_id '' -y >/dev/null 2>&1
echo "reset: adsense.settings adsense_basic_id='' (/ads.txt would 404)"
