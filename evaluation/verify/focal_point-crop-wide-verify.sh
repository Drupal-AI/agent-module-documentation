#!/usr/bin/env bash
# Live-state verification for the "eval_focal_wide focal-point crop at 16:9" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the image_style config entity `eval_focal_wide` exists and carries a
# `focal_point_crop` effect whose data width x height is 640x360 (a 16:9 size).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $style = \Drupal::entityTypeManager()->getStorage("image_style")->load("eval_focal_wide");
  $exists = (bool) $style;
  $eff = FALSE;
  if ($exists) {
    foreach ($style->getEffects() as $e) {
      $c = $e->getConfiguration();
      $w = (int) ($c["data"]["width"] ?? 0);
      $h = (int) ($c["data"]["height"] ?? 0);
      if (($c["id"] ?? "") === "focal_point_crop" && $w === 640 && $h === 360) { $eff = TRUE; }
    }
  }
  print (($exists && $eff) ? "PASS" : "FAIL")
    . " style=" . ($exists?1:0) . " crop640x360=" . ($eff?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
