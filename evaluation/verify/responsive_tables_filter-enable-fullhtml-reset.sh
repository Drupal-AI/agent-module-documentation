#!/usr/bin/env bash
# Execution RESET for "enable the Responsive Tables filter on Full HTML". Forces a known
# EMPTY baseline so verify FAILS until the agent does the work: remove any
# filter_responsive_tables_filter instance from filter.format.full_html. The agent must
# enable the filter on the Full HTML format. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("full_html");
  if ($fmt) {
    $fmt->filters()->removeInstanceId("filter_responsive_tables_filter");
    $fmt->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: responsive_tables_filter removed from full_html (agent must enable it)"
