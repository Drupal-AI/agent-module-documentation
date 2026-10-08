#!/usr/bin/env bash
# Execution VERIFY: PASS when plupload_test is enabled AND the route plupload.test resolves to
# path /plupload-test. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $why = "module-not-enabled";
  if (\Drupal::moduleHandler()->moduleExists("plupload_test")) {
    $why = "route-missing";
    try {
      $p = \Drupal::service("router.route_provider")->getRouteByName("plupload.test")->getPath();
      if ($p === "/plupload-test") { $ok = TRUE; $why = "route plupload.test => ".$p; }
      else { $why = "route path=".$p; }
    } catch (\Throwable $t) { $why = "no-route"; }
  }
  print (($ok) ? "PASS " : "FAIL ") . $why . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
