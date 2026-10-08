#!/usr/bin/env bash
# Execution VERIFY (autoban_dblog): PASS when the dblog.overview route is served by Autoban's
# AutobanDbLogController (i.e. the submodule is enabled and its route override is active).
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::service("router.route_provider")->getRouteByName("dblog.overview");
  $c = $r ? (string) $r->getDefault("_controller") : "";
  $ok = (strpos($c, "AutobanDbLogController") !== FALSE);
  print ($ok?"PASS":"FAIL")." controller=".$c."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
