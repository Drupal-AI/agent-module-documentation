#!/usr/bin/env bash
# Introspection SETUP: enable the Responsive Tables filter on the Basic HTML text format with
# a KNOWN configuration so an inspecting agent can read it back: mode = stack (the default),
# but the persistent-first-column option turned OFF (tablesaw_persist = FALSE). Stored in
# filter.format.basic_html -> filters.filter_responsive_tables_filter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("basic_html");
  if ($fmt) {
    $fmt->setFilterConfig("filter_responsive_tables_filter", [
      "status"   => TRUE,
      "settings" => ["tablesaw_type" => "stack", "tablesaw_persist" => FALSE],
    ]);
    $fmt->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: responsive_tables_filter enabled on basic_html (mode=stack, persist=off)"
