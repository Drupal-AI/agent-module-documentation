#!/usr/bin/env bash
# Live-state verification for "set the Documentation block soft_limit to 6".
# PASS if the ai_documentation component's soft_limit equals 6. Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $val = NULL;
  $layout = \Drupal::config("dashboard.dashboard.ai_dashboard")->get("layout");
  foreach (($layout[0]["components"] ?? []) as $c) {
    if (($c["configuration"]["id"] ?? "") === "ai_documentation") {
      $val = $c["configuration"]["soft_limit"] ?? NULL;
    }
  }
  $ok = ((int) $val === 6);
  print ($ok ? "PASS" : "FAIL") . " soft_limit=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
