#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("rest_views_revisions");
  $has = \Drupal::service("plugin.manager.field.formatter")->hasDefinition("entity_reference_revisions_export");
  $ok = $enabled && $has;
  print ($ok ? "PASS" : "FAIL") . " module=" . var_export($enabled, TRUE) . " formatter=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
