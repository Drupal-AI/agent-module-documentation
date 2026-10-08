#!/usr/bin/env bash
# Execution RESET: set lightning_api.settings to defaults (entity_json=false) so verify FAILS
# until the agent enables the "View JSON" link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lightning_api.settings")->setData(["entity_json"=>false,"bundle_docs"=>false])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lightning_api.settings entity_json=false"
