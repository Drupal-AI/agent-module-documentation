#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cmv_task on node.article default view display uses the
# colorbox_media_remote_video formatter. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_cmv_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "colorbox_media_remote_video");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
