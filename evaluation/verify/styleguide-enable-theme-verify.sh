#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'stark' theme is installed AND the styleguide.stark route
# exists (i.e. its style guide is available).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $installed = \Drupal::service("theme_handler")->themeExists("stark");
  $route = FALSE;
  try { \Drupal::service("router.route_provider")->getRouteByName("styleguide.stark"); $route = TRUE; }
  catch (\Exception $e) { $route = FALSE; }
  $ok = $installed && $route;
  print ($ok ? "PASS" : "FAIL") . " stark_installed=" . var_export($installed, TRUE) . " styleguide_route=" . var_export($route, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
