#!/usr/bin/env bash
# Execution VERIFY: PASS when typed_entity_ui is installed AND its explorer route
# typed_entity_ui.explore exists. Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("typed_entity_ui");
  $route = NULL;
  if ($enabled) {
    try { $route = \Drupal::service("router.route_provider")->getRouteByName("typed_entity_ui.explore"); } catch (\Throwable $e) { $route = NULL; }
  }
  $ok = $enabled && $route;
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " path=" . ($route ? $route->getPath() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
