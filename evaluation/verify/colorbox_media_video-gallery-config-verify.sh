#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cmv_grp keeps type colorbox_media_remote_video and its
# settings.colorbox_gallery === 'page'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_cmv_grp") : NULL;
  $type = $c["type"] ?? "none";
  $g = $c["settings"]["colorbox_gallery"] ?? "none";
  $ok = ($type === "colorbox_media_remote_video" && $g === "page");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " colorbox_gallery=" . $g . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
