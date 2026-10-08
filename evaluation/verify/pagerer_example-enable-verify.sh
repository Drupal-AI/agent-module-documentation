#!/usr/bin/env bash
# Execution VERIFY: PASS when pagerer_example is enabled AND its route pagerer_example.page
# (/pagerer/example) is registered. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("pagerer_example");
  $path = "none";
  try { $path = \Drupal::service("router.route_provider")->getRouteByName("pagerer_example.page")->getPath(); } catch (\Exception $e) {}
  $ok = ($enabled && $path === "/pagerer/example");
  print ((($ok) ? "PASS" : "FAIL")." enabled=".var_export($enabled,true)." path=".$path."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
