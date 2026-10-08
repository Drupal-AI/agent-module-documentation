#!/usr/bin/env bash
# Introspection CLEANUP: restore counter.entity_types to baseline ['node'].
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("counter.entity_types", ["node"])->save();' >/dev/null 2>&1
echo "cleanup: visitors.config counter.entity_types=[node]"
