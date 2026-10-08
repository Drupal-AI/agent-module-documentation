#!/usr/bin/env bash
# Introspection SETUP: enable the "View API Documentation" bundle operation (bundle_docs) so an
# agent can read the live lightning_api.settings state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("lightning_api.settings")->set("bundle_docs",true)->set("entity_json",false)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: lightning_api.settings bundle_docs=true"
