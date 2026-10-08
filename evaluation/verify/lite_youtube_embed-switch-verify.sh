#!/usr/bin/env bash
# Execution VERIFY: PASS when the ly_probe remote_video display renders the oEmbed video field with
# the lite_youtube_embed formatter.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $type = MediaType::load("remote_video");
  $sf = $type->getSource()->getSourceFieldDefinition($type)->getName();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.remote_video.ly_probe");
  $c = $vd ? $vd->getComponent($sf) : NULL;
  $ok = $c && ($c["type"] ?? "") === "lite_youtube_embed";
  print ($ok ? "PASS" : "FAIL") . " field=" . $sf . " type=" . var_export($c["type"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
