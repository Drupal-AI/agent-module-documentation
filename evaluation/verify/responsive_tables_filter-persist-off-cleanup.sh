#!/usr/bin/env bash
# Introspection CLEANUP: remove the Responsive Tables filter from the Basic HTML text format,
# undoing the known configuration set by the matching setup script and restoring baseline
# (basic_html has no responsive_tables_filter by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("basic_html");
  if ($fmt) {
    $fmt->filters()->removeInstanceId("filter_responsive_tables_filter");
    $fmt->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: responsive_tables_filter removed from basic_html"
