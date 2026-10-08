#!/usr/bin/env bash
# Execution VERIFY for "warm derivatives": PASS when the isg_gen derivative of
# public://isg_warm_src.png exists on disk. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $style = ImageStyle::load("isg_gen");
  $deriv = $style ? $style->buildUri("public://isg_warm_src.png") : "";
  $ok = $deriv && file_exists($deriv);
  print ($ok ? "PASS" : "FAIL") . " deriv=" . $deriv . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
