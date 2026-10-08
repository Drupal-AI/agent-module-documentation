#!/usr/bin/env bash
# Execution CLEANUP: restore adsense_group_title_1 to shipped default ''.
set -uo pipefail
cd /var/www/html
drush cset adsense_oldcode.settings adsense_group_title_1 '' -y >/dev/null 2>&1
echo "cleanup: adsense_oldcode.settings adsense_group_title_1 restored to ''"
