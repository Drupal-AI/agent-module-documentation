#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("preview_link.settings")->set("enabled_entity_types",[])->save();' >/dev/null 2>&1
echo "cleanup: enabled_entity_types cleared"
