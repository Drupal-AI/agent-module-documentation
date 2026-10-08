#!/usr/bin/env bash
# Execution VERIFY: PASS when the config_log view exists, has base_table config_log, and a
# display serving the path admin/reports/config-log. Read-only (config only). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("views.view.config_log");
  $id = $v->get("id");
  $base = $v->get("base_table");
  $path = NULL;
  foreach (($v->get("display") ?: []) as $d) {
    $p = $d["display_options"]["path"] ?? NULL;
    if ($p) { $path = $p; }
  }
  $ok = ($id === "config_log" && $base === "config_log" && $path === "admin/reports/config-log");
  print ($ok ? "PASS" : "FAIL") . " id=" . var_export($id, TRUE) . " base=" . var_export($base, TRUE) . " path=" . var_export($path, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
