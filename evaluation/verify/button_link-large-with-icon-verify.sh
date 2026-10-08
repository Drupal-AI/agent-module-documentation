#!/usr/bin/env bash
# Execution VERIFY: PASS when field_btl_task2 uses type=button_link with settings.btn_size=btn-lg
# and settings.icon_class='fa fa-star'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_btl_task2") : NULL;
  $type = $c["type"] ?? "none";
  $sz = $c["settings"]["btn_size"] ?? NULL;
  $ic = $c["settings"]["icon_class"] ?? NULL;
  $ok = ($type === "button_link") && ($sz === "btn-lg") && ($ic === "fa fa-star");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " btn_size=" . var_export($sz, TRUE) . " icon_class=" . var_export($ic, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
