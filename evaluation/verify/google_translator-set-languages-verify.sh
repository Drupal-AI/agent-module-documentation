#!/usr/bin/env bash
# Execution VERIFY: PASS when display mode is HORIZONTAL and active languages include 'ja'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("google_translator.settings");
  $mode = $c->get("google_translator_active_languages_display_mode");
  $langs = $c->get("google_translator_active_languages") ?: [];
  $ok = ($mode === "HORIZONTAL" && in_array("ja", $langs, TRUE));
  print ($ok ? "PASS" : "FAIL") . " mode=" . var_export($mode, TRUE) . " langs=" . implode(",", $langs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
