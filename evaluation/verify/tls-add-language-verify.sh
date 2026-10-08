#!/usr/bin/env bash
# Execution VERIFY: PASS when the German (de) language is enabled on the site. Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $langs = \Drupal::languageManager()->getLanguages();
  $ok = isset($langs["de"]);
  print ($ok ? "PASS" : "FAIL") . " de_enabled=" . ($ok ? "yes" : "no") . " langs=" . implode(",", array_keys($langs)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
