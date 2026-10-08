#!/usr/bin/env bash
# Execution RESET: no entity types enabled for preview links, so verify FAILS until the
# agent enables the Article bundle.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("preview_link.settings")->set("enabled_entity_types",[])->save();' >/dev/null 2>&1
echo "reset: preview_link enabled_entity_types cleared"
