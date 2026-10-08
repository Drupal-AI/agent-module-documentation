#!/usr/bin/env bash
# Execution VERIFY: PASS when multiple_select.settings:table (JSON) maps "node-article" to a
# list that includes field_ms_task. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("multiple_select.settings")->get("table");
  $d = $t ? json_decode($t, TRUE) : [];
  $list = $d["node-article"] ?? [];
  $ok = is_array($list) && in_array("field_ms_task", $list, TRUE);
  print ($ok ? "PASS" : "FAIL") . " table=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
