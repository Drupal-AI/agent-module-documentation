#!/usr/bin/env bash
# Execution CLEANUP: restore formtips.settings:formtips_trigger_action to shipped default 'click'.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_trigger_action click -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: formtips.settings formtips_trigger_action restored to click"
