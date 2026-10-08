#!/usr/bin/env bash
# Execution VERIFY: PASS when monitoring_demo is installed AND its landing route resolves AND the
# search_api.index.demo index exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("monitoring_demo");
  $route = FALSE;
  try { \Drupal::service("router.route_provider")->getRouteByName("monitoring_demo.front_page"); $route = TRUE; } catch (\Throwable $e) { $route = FALSE; }
  $index = FALSE;
  try { $index = (bool) \Drupal::entityTypeManager()->getStorage("search_api_index")->load("demo"); } catch (\Throwable $e) { $index = FALSE; }
  $ok = ($enabled && $route && $index);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled ? "yes" : "no") . " route=" . ($route ? "yes" : "no") . " index=" . ($index ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
