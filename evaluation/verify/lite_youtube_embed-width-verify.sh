#!/usr/bin/env bash
# Execution VERIFY: PASS when the ly_probe lite_youtube_embed formatter has max_width === 800.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $type = MediaType::load("remote_video");
  $sf = $type->getSource()->getSourceFieldDefinition($type)->getName();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.remote_video.ly_probe");
  $c = $vd ? $vd->getComponent($sf) : NULL;
  $ok = $c && ($c["type"] ?? "") === "lite_youtube_embed" && (int)($c["settings"]["max_width"] ?? 0) === 800;
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($c["type"] ?? NULL, TRUE) . " max_width=" . var_export($c["settings"]["max_width"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
