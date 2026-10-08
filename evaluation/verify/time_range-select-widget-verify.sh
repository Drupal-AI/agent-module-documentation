#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tr_task's widget on the default form display is time_range.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $c = $fd->getComponent("field_tr_task");
  $type = $c["type"] ?? "none";
  $ok = ($type === "time_range");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
