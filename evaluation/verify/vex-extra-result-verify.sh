#!/usr/bin/env bash
# Execution VERIFY: PASS when view vex_summary has an 'extra_result' area handler in its footer
# (plugin_id extra_result). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vex_summary");
  $ok = FALSE;
  if ($v) {
    $d = $v->get("display");
    $footer = $d["default"]["display_options"]["footer"] ?? [];
    foreach ($footer as $h) {
      if (($h["plugin_id"] ?? ($h["field"] ?? "")) === "extra_result") { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
