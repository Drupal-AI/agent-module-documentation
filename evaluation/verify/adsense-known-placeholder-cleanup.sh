#!/usr/bin/env bash
# Introspection CLEANUP: restore adsense_placeholder_text to shipped default 'Google AdSense'.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_placeholder_text 'Google AdSense' -y >/dev/null 2>&1
echo "cleanup: adsense.settings adsense_placeholder_text restored to 'Google AdSense'"
