#!/usr/bin/env bash
# Introspection SETUP: set adsense.settings:adsense_basic_id to a known (fake, local) publisher
# ID so the agent can read it back. No live Google call is made. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_basic_id 'ca-pub-1234567890123456' -y >/dev/null 2>&1
echo "setup: adsense.settings adsense_basic_id=ca-pub-1234567890123456"
