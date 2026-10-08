#!/usr/bin/env bash
# Execution VERIFY: PASS when image style ratiocrop_task has an image_crop_ratio effect with
# data.aspect_ratio '16:9' and data.anchor 'center-center'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("ratiocrop_task");
  $ok = FALSE; $ratio = "none"; $anchor = "none";
  if ($s) {
    foreach ($s->getEffects() as $e) {
      $c = $e->getConfiguration();
      if (($c["id"] ?? "") === "image_crop_ratio") {
        $ratio = $c["data"]["aspect_ratio"] ?? "none";
        $anchor = $c["data"]["anchor"] ?? "none";
        if ($ratio === "16:9" && $anchor === "center-center") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " ratio=" . $ratio . " anchor=" . $anchor . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
