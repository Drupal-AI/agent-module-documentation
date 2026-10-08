#!/usr/bin/env bash
# Execution VERIFY for "warm only isg_sela": PASS when the isg_sela derivative of
# public://isg_sel_src.png exists AND the isg_selb derivative does NOT (proving the
# --image-styles selection was applied, not a blanket warm). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $a = ImageStyle::load("isg_sela");
  $b = ImageStyle::load("isg_selb");
  $da = $a ? $a->buildUri("public://isg_sel_src.png") : "";
  $db = $b ? $b->buildUri("public://isg_sel_src.png") : "";
  $a_ok = $da && file_exists($da);
  $b_absent = !($db && file_exists($db));
  $ok = $a_ok && $b_absent;
  print ($ok ? "PASS" : "FAIL") . " sela=" . var_export($a_ok, TRUE) . " selb_absent=" . var_export($b_absent, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
