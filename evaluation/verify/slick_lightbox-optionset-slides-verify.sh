#!/usr/bin/env bash
# Execution VERIFY: PASS when slick.optionset.slick_lightbox options.settings.slidesToShow == 2
# (tolerant of int/float storage). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("slick.optionset.slick_lightbox")->get("options.settings.slidesToShow");
  $ok = (is_numeric($v) && ((int) round((float) $v)) === 2);
  print ($ok ? "PASS" : "FAIL") . " slidesToShow=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
