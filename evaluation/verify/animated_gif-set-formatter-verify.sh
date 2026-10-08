#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article.default view display renders field_ag_pic with the
# animated_gif_image_url formatter. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ag_pic") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "animated_gif_image_url") ? "PASS" : "FAIL") . " type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
