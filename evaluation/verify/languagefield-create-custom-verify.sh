#!/usr/bin/env bash
# Execution VERIFY: PASS when a languagefield custom_language config entity with id lf_new
# exists and carries a non-empty label. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("custom_language")->load("lf_new");
  $label = $e ? (string) $e->label() : "";
  $ok = ($e && $label !== "");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "yes" : "no") . " label=" . $label . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
