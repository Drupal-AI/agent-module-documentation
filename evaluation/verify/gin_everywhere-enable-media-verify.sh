#!/usr/bin/env bash
# VERIFY: PASS when gin_everywhere is enabled AND its route-alter adds "entity.media.canonical".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("gin_everywhere")) { print "FAIL module=disabled\n"; return; }
  $svc = \Drupal::service(\Drupal\gin_everywhere\Hook\GinEverywhereHooks::class);
  $routes = [];
  $svc->ginContentFormRoutesAlter($routes);
  $ok = in_array("entity.media.canonical", $routes, TRUE);
  print ($ok ? "PASS" : "FAIL") . " module=enabled route_present=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
