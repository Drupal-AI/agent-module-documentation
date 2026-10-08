#!/usr/bin/env bash
# Execution VERIFY: PASS when image style tinypng_task carries third_party_setting
# tinypng.tinypng_compress === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("tinypng_task");
  $v = $s ? $s->getThirdPartySetting("tinypng", "tinypng_compress") : NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " style=" . ($s ? "1" : "0") . " tinypng_compress=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
