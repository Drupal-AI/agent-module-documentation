#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_fa_wtask") : NULL;
  $type = $c["type"] ?? "none";
  print (($type === "font_awesome_icon_picker_widget") ? "PASS" : "FAIL") . " widget=$type";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
