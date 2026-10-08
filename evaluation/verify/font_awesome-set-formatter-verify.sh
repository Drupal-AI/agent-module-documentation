#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fa_task uses the font_awesome_icon formatter with size fa-3x
# in the default Article view display. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fa_task") : NULL;
  $type = $c["type"] ?? "none";
  $size = $c["settings"]["size"] ?? "none";
  $ok = ($type === "font_awesome_icon") && ($size === "fa-3x");
  print ($ok ? "PASS" : "FAIL") . " type=$type size=$size";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
