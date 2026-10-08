#!/usr/bin/env bash
# Introspection SETUP: set the legacy search Google country domain to a known value so the agent
# can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset adsense_oldcode.settings adsense_search_country 'www.google.co.uk' -y >/dev/null 2>&1
echo "setup: adsense_oldcode.settings adsense_search_country='www.google.co.uk'"
