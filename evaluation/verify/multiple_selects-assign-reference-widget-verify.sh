#!/usr/bin/env bash
# Execution VERIFY for "switch field_msel_task to the multiple_selects widget".
# PASS when the field's component in core.entity_form_display.node.msel_ct.default carries
# type === "multiple_options_select". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.msel_ct.default");
  $c = $fd ? $fd->getComponent("field_msel_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "multiple_options_select");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
