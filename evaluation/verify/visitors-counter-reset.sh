#!/usr/bin/env bash
# Execution RESET: set the hit-counter entity types to just ['node'] so verify FAILS until the
# agent adds 'user'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("counter.entity_types", ["node"])->save();' >/dev/null 2>&1
echo "reset: visitors.config counter.entity_types=[node]"
