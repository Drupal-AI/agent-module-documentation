#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("counter.entity_types", ["node"])->save();' >/dev/null 2>&1
echo "cleanup: visitors.config counter.entity_types=[node]"
