#!/usr/bin/env bash
# Introspection SETUP: enable the "View JSON" entity operation (entity_json) so an agent can
# read the live lightning_api.settings state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lightning_api.settings")->set("entity_json",true)->set("bundle_docs",false)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: lightning_api.settings entity_json=true"
