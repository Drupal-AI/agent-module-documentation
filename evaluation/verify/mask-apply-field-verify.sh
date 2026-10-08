#!/usr/bin/env bash
# Execution VERIFY: PASS when field_mask_task's string_textfield component on node.mask_ct.default
# carries third_party_settings.mask.value === "00/00/0000". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","mask_ct","default");
  $c = $fd ? $fd->getComponent("field_mask_task") : NULL;
  $v = $c["third_party_settings"]["mask"]["value"] ?? NULL;
  $ok = ($v === "00/00/0000");
  print ($ok ? "PASS" : "FAIL") . " mask=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
