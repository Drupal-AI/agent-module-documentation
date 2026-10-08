#!/usr/bin/env bash
# Execution VERIFY: PASS when image style ratiocrop_square has an image_crop_ratio effect with
# data.aspect_ratio '1:1' and data.anchor 'center-top'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("ratiocrop_square");
  $ok = FALSE; $ratio = "none"; $anchor = "none";
  if ($s) {
    foreach ($s->getEffects() as $e) {
      $c = $e->getConfiguration();
      if (($c["id"] ?? "") === "image_crop_ratio") {
        $ratio = $c["data"]["aspect_ratio"] ?? "none";
        $anchor = $c["data"]["anchor"] ?? "none";
        if ($ratio === "1:1" && $anchor === "center-top") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " ratio=" . $ratio . " anchor=" . $anchor . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
