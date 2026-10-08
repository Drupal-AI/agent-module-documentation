#!/usr/bin/env bash
# Execution VERIFY: PASS when mobile_presets contains {name:'Tablet ME', width:800, height:1000}.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $presets = \Drupal::config("mercury_editor.settings")->get("mobile_presets") ?: [];
  $ok = FALSE;
  foreach ($presets as $p) {
    if (($p["name"] ?? "") === "Tablet ME" && (int)($p["width"] ?? 0) === 800 && (int)($p["height"] ?? 0) === 1000) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " count=" . count($presets) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
