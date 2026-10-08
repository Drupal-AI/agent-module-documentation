#!/usr/bin/env bash
# PASS when field_owl_pic uses owlcarousel_field_formatter with 5 items.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")->getComponent("field_owl_pic");
  $type = $c["type"] ?? "none"; $items = isset($c["settings"]["items"]) ? (int)$c["settings"]["items"] : -1;
  $ok = ($type === "owlcarousel_field_formatter") && ($items === 5);
  print ($ok ? "PASS" : "FAIL") . " type=$type items=$items\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
