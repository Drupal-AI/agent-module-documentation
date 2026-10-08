#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("rest_views_search_api");
  $has = \Drupal::service("plugin.manager.views.field")->hasDefinition("search_api_field_export");
  $ok = $enabled && $has;
  print ($ok ? "PASS" : "FAIL") . " module=" . var_export($enabled, TRUE) . " handler=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
