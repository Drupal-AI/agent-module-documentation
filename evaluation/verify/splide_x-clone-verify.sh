#!/usr/bin/env bash
# Execution VERIFY: PASS when a new optionset x_clone exists whose options.settings.type matches the
# shipped x_carousel example (i.e. it was cloned from it). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\splide\Entity\Splide;
  $clone = Splide::load("x_clone");
  $srcType = \Drupal::config("splide.optionset.x_carousel")->get("options.settings.type");
  $cloneType = \Drupal::config("splide.optionset.x_clone")->get("options.settings.type");
  $ok = ($clone && $srcType !== NULL && $cloneType === $srcType);
  print ($ok?"PASS":"FAIL")." x_clone=".($clone?"yes":"no")." x_carousel.type=".var_export($srcType,TRUE)." x_clone.type=".var_export($cloneType,TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
