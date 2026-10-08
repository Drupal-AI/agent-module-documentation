#!/usr/bin/env bash
# Execution VERIFY: PASS when isq_task_style has an image_style_quality effect with quality === 55.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("isq_task_style");
  $q = NULL;
  if ($s) { foreach ($s->getEffects() as $e) { if ($e->getPluginId()==="image_style_quality") { $q = $e->getConfiguration()["data"]["quality"] ?? NULL; } } }
  $ok = ((int) $q === 55);
  print ($ok ? "PASS" : "FAIL") . " quality=" . var_export($q, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
