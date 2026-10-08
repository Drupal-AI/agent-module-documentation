#!/usr/bin/env bash
# Introspection SETUP: enable the Responsive Tables filter on the Full HTML text format with
# a KNOWN, distinctive configuration so an inspecting agent can read it back: mode = swipe,
# persistent first column = OFF. Stored in filter.format.full_html ->
# filters.filter_responsive_tables_filter. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("full_html");
  if ($fmt) {
    $fmt->setFilterConfig("filter_responsive_tables_filter", [
      "status"   => TRUE,
      "settings" => ["tablesaw_type" => "swipe", "tablesaw_persist" => FALSE],
    ]);
    $fmt->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: responsive_tables_filter enabled on full_html (mode=swipe, persist=off)"
