#!/usr/bin/env bash
# Execution VERIFY for "restrict field_ltgt_promo's available_targets to only _blank".
# PASS when the field's component in core.entity_form_display.node.ltgt_ct.default keeps
# type link_target_field_widget AND settings.available_targets is truthy only for _blank
# (self/parent/top unchecked or absent). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.ltgt_ct.default");
  $c = $fd ? $fd->getComponent("field_ltgt_promo") : NULL;
  $type = $c["type"] ?? "none";
  $avail = $c["settings"]["available_targets"] ?? [];
  $blank_on = !empty($avail["_blank"]);
  $others_off = empty($avail["_self"]) && empty($avail["parent"]) && empty($avail["top"]);
  $ok = ($type === "link_target_field_widget") && $blank_on && $others_off;
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " available_targets=" . json_encode($avail) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
