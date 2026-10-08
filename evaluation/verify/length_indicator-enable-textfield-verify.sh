#!/usr/bin/env bash
# Execution VERIFY: PASS when field_li_task component in the default form display has
# length_indicator.indicator === TRUE with optimin=50, optimax=70, tolerance=8.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_li_task") : NULL;
  $li = $c["third_party_settings"]["length_indicator"] ?? [];
  $on = ($li["indicator"] ?? NULL) === TRUE;
  $o = $li["indicator_opt"] ?? [];
  $vals = ((int)($o["optimin"]??0)===50 && (int)($o["optimax"]??0)===70 && (int)($o["tolerance"]??-1)===8);
  $ok = $on && $vals;
  print ($ok ? "PASS" : "FAIL") . " indicator=" . var_export($li["indicator"] ?? NULL, TRUE) . " opt=" . json_encode($o) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
