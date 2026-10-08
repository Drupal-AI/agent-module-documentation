#!/usr/bin/env bash
# Execution VERIFY for "restore ckeditor_media_resize's shipped image styles".
# PASS when all four cke_media_resize_* image styles exist on the live site and each has an
# image_scale effect with the width the module ships (200/500/800/1200) and upscale = TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $expected = [
    "cke_media_resize_small" => 200,
    "cke_media_resize_medium" => 500,
    "cke_media_resize_large" => 800,
    "cke_media_resize_xl" => 1200,
  ];
  $storage = \Drupal::entityTypeManager()->getStorage("image_style");
  $report = [];
  $ok = TRUE;
  foreach ($expected as $id => $width) {
    $style = $storage->load($id);
    if (!$style) { $report[$id] = "missing"; $ok = FALSE; continue; }
    $found = NULL;
    $upscale = NULL;
    foreach ($style->getEffects() as $effect) {
      $c = $effect->getConfiguration();
      if (($c["id"] ?? "") === "image_scale") {
        $found = (int) ($c["data"]["width"] ?? 0);
        $upscale = $c["data"]["upscale"] ?? NULL;
      }
    }
    $report[$id] = "scale=" . var_export($found, TRUE) . ",upscale=" . var_export($upscale, TRUE);
    if ($found !== $width || $upscale !== TRUE) { $ok = FALSE; }
  }
  print ($ok ? "PASS" : "FAIL") . " " . json_encode($report) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
