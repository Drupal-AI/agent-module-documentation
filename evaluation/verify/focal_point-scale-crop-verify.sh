#!/usr/bin/env bash
# Live-state verification for the "eval_focal_crop scale-and-crop 300x300" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the image_style config entity `eval_focal_crop` exists and carries a
# `focal_point_scale_and_crop` effect whose data width and height are both 300.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $style = \Drupal::entityTypeManager()->getStorage("image_style")->load("eval_focal_crop");
  $exists = (bool) $style;
  $eff = FALSE;
  if ($exists) {
    foreach ($style->getEffects() as $e) {
      $c = $e->getConfiguration();
      if (($c["id"] ?? "") === "focal_point_scale_and_crop"
          && (int) ($c["data"]["width"] ?? 0) === 300
          && (int) ($c["data"]["height"] ?? 0) === 300) { $eff = TRUE; }
    }
  }
  print (($exists && $eff) ? "PASS" : "FAIL")
    . " style=" . ($exists?1:0) . " effect300x300=" . ($eff?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
