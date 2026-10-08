#!/usr/bin/env bash
# Introspection SETUP: set a known ad-style title in adsense_oldcode.settings so the agent can
# read it back. Local config only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense_oldcode.settings adsense_group_title_1 'OC Known Style' -y >/dev/null 2>&1
echo "setup: adsense_oldcode.settings adsense_group_title_1='OC Known Style'"
