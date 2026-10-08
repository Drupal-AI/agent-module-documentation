#!/usr/bin/env bash
# Execution VERIFY: PASS when field_li_area component has length_indicator.indicator === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_li_area") : NULL;
  $li = $c["third_party_settings"]["length_indicator"] ?? [];
  $on = ($li["indicator"] ?? NULL) === TRUE;
  $o = $li["indicator_opt"] ?? [];
  $vals = isset($o["optimin"],$o["optimax"],$o["tolerance"]) && (int)$o["optimax"] > (int)$o["optimin"];
  $ok = $on && $vals && $c["type"] === "string_textarea";
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " indicator=" . var_export($li["indicator"] ?? NULL, TRUE) . " opt=" . json_encode($o) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
