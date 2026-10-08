#!/usr/bin/env bash
# Execution VERIFY: PASS when the imagick_task image style exists and contains an Imagick
# blur effect (plugin id image_blur). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $style = \Drupal::entityTypeManager()->getStorage("image_style")->load("imagick_task");
  $has = FALSE;
  if ($style) { foreach ($style->getEffects() as $e) { if ($e->getPluginId() === "image_blur") { $has = TRUE; } } }
  print (($style && $has) ? "PASS" : "FAIL") . " style=" . ($style ? "yes" : "no") . " image_blur=" . ($has ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
