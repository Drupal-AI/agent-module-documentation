#!/usr/bin/env bash
# Introspection CLEANUP: clear numeric_field_names back to baseline (empty). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contextual_range_filter.settings")->set("numeric_field_names",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: contextual_range_filter.settings numeric_field_names=[]"
