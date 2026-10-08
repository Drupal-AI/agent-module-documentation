#!/usr/bin/env bash
# Execution VERIFY: PASS when group_prefix = alpha 'Letters', numeric 'Numbers', special 'Symbols'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = (array) \Drupal::config("search_api_glossary.settings")->get("group_prefix");
  $ok = (($g["alpha"] ?? "") === "Letters" && ($g["numeric"] ?? "") === "Numbers" && ($g["special"] ?? "") === "Symbols");
  print ($ok ? "PASS" : "FAIL") . " alpha=" . ($g["alpha"] ?? "") . " numeric=" . ($g["numeric"] ?? "") . " special=" . ($g["special"] ?? "") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
