#!/usr/bin/env bash
# Execution VERIFY: PASS when field_btl_task component uses type=button_link and
# settings.btn_type===btn-primary in the live default view display. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_btl_task") : NULL;
  $type = $c["type"] ?? "none";
  $bt = $c["settings"]["btn_type"] ?? NULL;
  $ok = ($type === "button_link") && ($bt === "btn-primary");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " btn_type=" . var_export($bt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
