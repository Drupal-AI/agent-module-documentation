#!/usr/bin/env bash
# Execution VERIFY: PASS when the router contains at least one route whose name starts with
# 'theme_compiler.' (built from a theme's theme_compiler.yml). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = 0;
  foreach (\Drupal::service("router.route_provider")->getAllRoutes() as $name => $r) {
    if (strpos($name, "theme_compiler.") === 0) { $c++; }
  }
  print ($c > 0 ? "PASS" : "FAIL") . " theme_compiler_routes=" . $c;
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
