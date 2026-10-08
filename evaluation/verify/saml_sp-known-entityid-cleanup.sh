#!/usr/bin/env bash
# Restore shipped default (empty entity_id).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("saml_sp.settings")->set("entity_id", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: saml_sp.settings entity_id restored to ''"
