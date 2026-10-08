#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fwam_task's component in
# core.entity_form_display.node.article.default has
# third_party_settings.field_widget_add_more.add_more === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_fwam_task") : NULL;
  $v = $c["third_party_settings"]["field_widget_add_more"]["add_more"] ?? NULL;
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " add_more=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
