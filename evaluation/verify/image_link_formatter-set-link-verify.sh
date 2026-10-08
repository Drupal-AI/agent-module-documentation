#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ilf_img uses image_link_formatter wrapping field_ilf_link.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ilf_img") : NULL;
  $type = $c["type"] ?? "none";
  $link = $c["settings"]["image_link"] ?? "";
  $ok = ($type === "image_link_formatter" && $link === "field_ilf_link");
  print ($ok ? "PASS" : "FAIL") . " type=$type image_link=" . var_export($link, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
