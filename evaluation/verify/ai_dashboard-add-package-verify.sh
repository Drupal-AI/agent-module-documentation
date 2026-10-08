#!/usr/bin/env bash
# Live-state verification for "add the AI Tools package to the Extensions block".
# PASS if the module_list_packages component's packages setting contains "AI Tools".
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = FALSE; $val = "";
  $layout = \Drupal::config("dashboard.dashboard.ai_dashboard")->get("layout");
  foreach (($layout[0]["components"] ?? []) as $c) {
    if (($c["configuration"]["id"] ?? "") === "module_list_packages") {
      $val = (string) ($c["configuration"]["packages"] ?? "");
      // Match "AI Tools" as a whole line (avoid partial matches).
      foreach (preg_split("/\r\n|\r|\n/", $val) as $line) {
        if (trim($line) === "AI Tools") { $found = TRUE; }
      }
    }
  }
  print ($found ? "PASS" : "FAIL") . " found=" . ($found?1:0) . " packages=" . json_encode($val) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
