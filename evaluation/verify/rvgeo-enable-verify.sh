#!/usr/bin/env bash
# Execution VERIFY: PASS when rest_views_geo is enabled AND the geolocation export field
# formatter (geolocation_latlng_formatter_export) is registered.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("rest_views_geo");
  $has = \Drupal::service("plugin.manager.field.formatter")->hasDefinition("geolocation_latlng_formatter_export");
  $ok = $enabled && $has;
  print ($ok ? "PASS" : "FAIL") . " module=" . var_export($enabled, TRUE) . " formatter=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
