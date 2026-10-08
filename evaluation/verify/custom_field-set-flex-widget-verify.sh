#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cf_disp component in node.cf_eval.default form display has
# type == custom_flex. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.cf_eval.default");
  $c = $fd ? $fd->getComponent("field_cf_disp") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "custom_flex");
  print ($ok?"PASS":"FAIL")." widget=".$type."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
