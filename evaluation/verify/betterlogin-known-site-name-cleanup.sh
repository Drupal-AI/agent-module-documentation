#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline site name 'module-documentor'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("system.site")->set("name", "module-documentor")->save();' >/dev/null 2>&1
echo "cleanup: system.site name='module-documentor' (baseline)"
