#!/usr/bin/env bash
# Introspection CLEANUP: remove the taxonomy_import.config override (baseline = code defaults).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("taxonomy_import.config")->delete();' >/dev/null 2>&1
echo "cleanup: taxonomy_import.config deleted (defaults restored)"
