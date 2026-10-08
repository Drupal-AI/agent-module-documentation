#!/usr/bin/env bash
# Execution CLEANUP: restore the two keys to shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings hide_default_button 0 >/dev/null 2>&1
drush cset -y entity_share_websub_subscriber.settings subscribe_hub_url '' >/dev/null 2>&1
echo "cleanup: settings restored to defaults"
