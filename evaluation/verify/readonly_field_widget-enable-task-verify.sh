#!/usr/bin/env bash
# Execution VERIFY for "switch field_rofw_task's widget to readonly_field_widget".
# PASS when the field's component in core.entity_form_display.node.article.default has
# type === readonly_field_widget. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_rofw_task") : NULL;
  $type = $c["type"] ?? NULL;
  $ok = ($type === "readonly_field_widget");
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($type ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
