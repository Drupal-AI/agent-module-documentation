#!/usr/bin/env bash
# Introspection CLEANUP: restore adsense_search_country to shipped default 'www.google.com'.
set -uo pipefail
cd /var/www/html
drush cset adsense_oldcode.settings adsense_search_country 'www.google.com' -y >/dev/null 2>&1
echo "cleanup: adsense_oldcode.settings adsense_search_country restored to 'www.google.com'"
