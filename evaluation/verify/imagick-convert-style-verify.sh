#!/usr/bin/env bash
# Execution VERIFY: PASS when the imagick_webp image style exists and contains the Imagick
# convert effect (plugin id image_convert) set to output WEBP. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $style = \Drupal::entityTypeManager()->getStorage("image_style")->load("imagick_webp");
  $fmt = "";
  if ($style) { foreach ($style->getEffects() as $e) { if ($e->getPluginId() === "image_convert") { $c = $e->getConfiguration(); $fmt = strtoupper($c["data"]["format"] ?? ""); } } }
  $ok = ($style && $fmt === "WEBP");
  print ($ok ? "PASS" : "FAIL") . " style=" . ($style ? "yes" : "no") . " format=" . $fmt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
