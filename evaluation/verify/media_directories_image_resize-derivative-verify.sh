#!/usr/bin/env bash
# Execution VERIFY for "generate a 120x90 derivative of public://mdir-task/hero.png".
# PASS when the derivative file exists at the path the module's DERIVATIVE_DIRECTORY scheme
# dictates (public://resize/120x90/mdir-task/hero.png) AND its real pixel dimensions are
# 120x90. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $uri = "public://resize/120x90/mdir-task/hero.png";
  $exists = file_exists($uri);
  $w = $h = NULL;
  if ($exists) {
    $image = \Drupal::service("image.factory")->get($uri);
    if ($image->isValid()) { $w = (int) $image->getWidth(); $h = (int) $image->getHeight(); }
  }
  $ok = $exists && $w === 120 && $h === 90;
  print ($ok ? "PASS" : "FAIL") . " uri=" . $uri . " exists=" . var_export($exists, TRUE) . " dims=" . var_export($w, TRUE) . "x" . var_export($h, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
