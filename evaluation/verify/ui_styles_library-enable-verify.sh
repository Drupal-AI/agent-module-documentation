#!/usr/bin/env bash
# Execution VERIFY (ui_styles_library): PASS when the module is enabled AND its styles library
# route (ui_styles_library.overview, /admin/appearance/ui/styles) is registered.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("ui_styles_library");
  $route = NULL;
  if ($enabled) {
    try { $route = \Drupal::service("router.route_provider")->getRouteByName("ui_styles_library.overview"); }
    catch (\Throwable $e) { $route = NULL; }
  }
  $path = $route ? $route->getPath() : "";
  $ok = ($enabled && $path === "/admin/appearance/ui/styles");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " path=" . $path . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
