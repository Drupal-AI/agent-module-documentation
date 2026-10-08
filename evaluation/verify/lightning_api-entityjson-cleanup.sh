#!/usr/bin/env bash
# Introspection CLEANUP: restore lightning_api.settings defaults (both false). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lightning_api.settings")->setData(["entity_json"=>false,"bundle_docs"=>false])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: lightning_api.settings restored to defaults"
