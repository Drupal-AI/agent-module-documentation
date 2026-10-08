#!/usr/bin/env bash
# Execution VERIFY: PASS when the English overrides contain source 'Search' -> 'Find'
# (empty context). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $contexts = \Drupal::config("stringoverrides.string_override.en")->get("contexts") ?: [];
  $ok = FALSE;
  foreach ($contexts as $ctx) {
    foreach (($ctx["translations"] ?? []) as $t) {
      if (($t["source"] ?? "") === "Search" && ($t["translation"] ?? "") === "Find") { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
