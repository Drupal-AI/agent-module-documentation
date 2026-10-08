#!/usr/bin/env bash
# Execution RESET for "set the Responsive Tables filter on Basic HTML to Column Toggle mode".
# Forces a known WRONG baseline so verify FAILS until the agent fixes it: enable the filter
# on filter.format.basic_html but with the DEFAULT stack mode (tablesaw_type=stack). The
# agent must change the mode to columntoggle (leaving the filter enabled). Idempotent.
# Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("basic_html");
  if ($fmt) {
    $fmt->setFilterConfig("filter_responsive_tables_filter", [
      "status"   => TRUE,
      "settings" => ["tablesaw_type" => "stack", "tablesaw_persist" => TRUE],
    ]);
    $fmt->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: basic_html responsive filter enabled with mode=stack (agent must set columntoggle)"
