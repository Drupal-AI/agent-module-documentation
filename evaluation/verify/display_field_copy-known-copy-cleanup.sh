#!/usr/bin/env bash
# Introspection CLEANUP: remove the ds.field.dfc_known config created by setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ds.field.dfc_known")->delete();
  \Drupal::service("cache_tags.invalidator")->invalidateTags(["ds_fields_info"]);
' >/dev/null 2>&1
echo "cleanup: ds.field.dfc_known removed"
