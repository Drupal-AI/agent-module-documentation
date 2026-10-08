#!/usr/bin/env bash
# Execution VERIFY: PASS when fitvids.settings selectors contains the '.content' selector.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $sel = (string) (\Drupal::config("fitvids.settings")->get("selectors") ?? "");
  $ok = (strpos($sel, ".content") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " selectors=" . str_replace("\n", "\\n", $sel) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
