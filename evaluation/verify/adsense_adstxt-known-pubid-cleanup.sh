#!/usr/bin/env bash
# Introspection CLEANUP: restore adsense.settings:adsense_basic_id to shipped default ''.
set -uo pipefail
cd /var/www/html
drush cset adsense.settings adsense_basic_id '' -y >/dev/null 2>&1
echo "cleanup: adsense.settings adsense_basic_id restored to ''"
