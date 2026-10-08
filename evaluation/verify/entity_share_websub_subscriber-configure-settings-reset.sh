#!/usr/bin/env bash
# Execution RESET: force the two target keys to their shipped defaults so verify FAILS until
# the agent sets them (hide_default_button=false, subscribe_hub_url=''). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings hide_default_button 0 >/dev/null 2>&1
drush cset -y entity_share_websub_subscriber.settings subscribe_hub_url '' >/dev/null 2>&1
echo "reset: hide_default_button=false, subscribe_hub_url=''"
