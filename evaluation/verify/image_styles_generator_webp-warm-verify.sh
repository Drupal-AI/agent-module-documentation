#!/usr/bin/env bash
# Execution VERIFY for the WebP warm case: PASS when a .webp copy of the isg_webp derivative of
# public://isg_wsrc.png exists on disk (proving the WebP submodule ran during warming).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $style = ImageStyle::load("isg_webp");
  $deriv = $style ? $style->buildUri("public://isg_wsrc.png") : "";
  $webp = $deriv ? preg_replace("/\\.png$/", ".webp", $deriv) : "";
  $ok = $webp && file_exists($webp);
  print ($ok ? "PASS" : "FAIL") . " webp=" . $webp . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
