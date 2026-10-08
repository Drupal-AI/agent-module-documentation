#!/usr/bin/env bash
# Execution RESET: clear adsense.settings:adsense_basic_id so verify FAILS until the agent sets
# the publisher ID. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_basic_id '' -y >/dev/null 2>&1
echo "reset: adsense.settings adsense_basic_id='' (unset)"
