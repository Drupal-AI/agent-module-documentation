#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ot_task's widget in the default form display is
# options_table. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ot_task") : NULL;
  $type = $c["type"] ?? "none";
  print (($type === "options_table") ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
