#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tr_shift uses the time_range widget with start_label
# 'Shift start' and end_label 'Shift end'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $c = $fd->getComponent("field_tr_shift");
  $type = $c["type"] ?? "none";
  $s = $c["settings"]["start_label"] ?? "";
  $e = $c["settings"]["end_label"] ?? "";
  $ok = ($type === "time_range" && $s === "Shift start" && $e === "Shift end");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " start=" . $s . " end=" . $e . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
