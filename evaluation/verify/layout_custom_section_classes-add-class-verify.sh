#!/usr/bin/env bash
# Execution VERIFY: PASS when the module's predefined class_list contains an entry for
# 'lcsc-task-class' (bare or with a |Friendly name). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("layout_custom_section_classes.settings")->get("class_list") ?: [];
  $found = FALSE;
  foreach ($list as $item) { if (strpos((string) $item, "lcsc-task-class") === 0) { $found = TRUE; } }
  print ($found ? "PASS" : "FAIL") . " class_list=" . json_encode($list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
