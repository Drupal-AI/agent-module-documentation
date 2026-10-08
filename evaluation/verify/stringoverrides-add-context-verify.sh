#!/usr/bin/env bash
# Execution VERIFY: PASS when the English overrides map source 'May' -> 'Mai' under the
# non-empty context 'Long month name'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $contexts = \Drupal::config("stringoverrides.string_override.en")->get("contexts") ?: [];
  $ok = FALSE;
  foreach ($contexts as $ctx) {
    if (($ctx["context"] ?? "") === "Long month name") {
      foreach (($ctx["translations"] ?? []) as $t) {
        if (($t["source"] ?? "") === "May" && ($t["translation"] ?? "") === "Mai") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
