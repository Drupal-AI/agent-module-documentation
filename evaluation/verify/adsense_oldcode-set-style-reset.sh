#!/usr/bin/env bash
# Execution RESET: clear adsense_group_title_1 so verify FAILS until the agent names the style.
set -uo pipefail
cd /var/www/html
drush cset adsense_oldcode.settings adsense_group_title_1 '' -y >/dev/null 2>&1
echo "reset: adsense_oldcode.settings adsense_group_title_1='' (unset)"
