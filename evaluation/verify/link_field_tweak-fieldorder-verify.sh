#!/usr/bin/env bash
# Execution VERIFY: PASS when field_lft_task widget in node.article.default has
# third_party_settings.link_field_tweak.link_default_field_order === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_lft_task") : NULL;
  $v = $c["third_party_settings"]["link_field_tweak"]["link_default_field_order"] ?? NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " link_default_field_order=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
