#!/usr/bin/env bash
# Introspection SETUP: set adsense.settings:adsense_basic_id so /ads.txt would advertise it.
# The submodule derives its output from this key. No live Google call. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_basic_id 'ca-pub-1111222233334444' -y >/dev/null 2>&1
echo "setup: adsense.settings adsense_basic_id=ca-pub-1111222233334444 (advertised in /ads.txt)"
