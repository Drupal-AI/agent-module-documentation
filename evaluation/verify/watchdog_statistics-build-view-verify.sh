#!/usr/bin/env bash
# Execution VERIFY: PASS when a View 'ws_eval_report' exists with base_table watchdog and at
# least one field handler whose plugin_id is watchdog_message_count (the Message count field).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("ws_eval_report");
  if (!$v) { print "FAIL no-view\n"; }
  else {
    $base = $v->get("base_table");
    $has_count = FALSE;
    foreach ($v->get("display") as $display) {
      foreach (($display["display_options"]["fields"] ?? []) as $f) {
        if (($f["plugin_id"] ?? "") === "watchdog_message_count") { $has_count = TRUE; }
      }
    }
    $ok = ($base === "watchdog" && $has_count);
    print ($ok ? "PASS" : "FAIL") . " base=" . var_export($base, TRUE) . " count_field=" . var_export($has_count, TRUE) . "\n";
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
