#!/usr/bin/env bash
# Execution VERIFY: PASS when splide.optionset.spl_edit has autoplay enabled (truthy). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("splide.optionset.spl_edit")->get("options.settings.autoplay");
  $b = filter_var($v, FILTER_VALIDATE_BOOLEAN);
  print (($b?"PASS":"FAIL")." autoplay=".var_export($v,TRUE));
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
