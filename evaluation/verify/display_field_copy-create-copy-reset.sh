#!/usr/bin/env bash
# Execution RESET: ensure NO display_field_copy named dfc_task exists, so verify FAILS on
# empty state until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ds.field.dfc_task")->delete();
  \Drupal::service("cache_tags.invalidator")->invalidateTags(["ds_fields_info"]);
' >/dev/null 2>&1
echo "reset: ds.field.dfc_task removed (absent)"
