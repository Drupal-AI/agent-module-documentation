#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default (no entity types enabled).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("preview_link.settings")->set("enabled_entity_types",[])->save();' >/dev/null 2>&1
echo "cleanup: enabled_entity_types restored to empty"
