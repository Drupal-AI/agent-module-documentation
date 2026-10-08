#!/usr/bin/env bash
# Execution VERIFY: PASS when codemirror_editor.settings language_modes includes BOTH css and
# twig. Pure config read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("codemirror_editor.settings")->get("language_modes") ?: [];
  $ok = in_array("css", $m, TRUE) && in_array("twig", $m, TRUE);
  print (($ok) ? "PASS" : "FAIL") . " language_modes=" . json_encode(array_values($m)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
