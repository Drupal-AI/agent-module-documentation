#!/usr/bin/env bash
# Introspection CLEANUP: clear string_field_names back to baseline (empty). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contextual_range_filter.settings")->set("string_field_names",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: contextual_range_filter.settings string_field_names=[]"
