#!/usr/bin/env bash
# Execution VERIFY: PASS when field_oel_task's default view-display formatter type is
# lazyload_oembed. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_oel_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "lazyload_oembed") ? "PASS" : "FAIL") . " formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
