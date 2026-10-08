#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'thumbnail' image style is in initial_image_styles (i.e. it
# is generated on upload). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $init = (array) \Drupal::config("image_style_warmer.settings")->get("initial_image_styles");
  $ok = in_array("thumbnail", $init, TRUE);
  print ($ok ? "PASS" : "FAIL") . " initial=" . implode(",", array_values($init)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
