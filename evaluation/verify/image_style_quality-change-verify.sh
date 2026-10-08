#!/usr/bin/env bash
# Execution VERIFY: PASS when isq_mod_style image_style_quality effect quality === 60.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("isq_mod_style");
  $q = NULL;
  if ($s) { foreach ($s->getEffects() as $e) { if ($e->getPluginId()==="image_style_quality") { $q = $e->getConfiguration()["data"]["quality"] ?? NULL; } } }
  $ok = ((int) $q === 60);
  print ($ok ? "PASS" : "FAIL") . " quality=" . var_export($q, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
