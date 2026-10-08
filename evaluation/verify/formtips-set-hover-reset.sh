#!/usr/bin/env bash
# Execution RESET: force formtips.settings:formtips_trigger_action to the default 'click' so
# verify FAILS until the agent switches it to 'hover'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_trigger_action click -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: formtips.settings formtips_trigger_action=click"
