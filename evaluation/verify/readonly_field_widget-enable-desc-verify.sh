#!/usr/bin/env bash
# Execution VERIFY for "switch field_rofw_desc's widget to readonly_field_widget rendered
# with the 'string' formatter". PASS when the field's component in
# core.entity_form_display.node.article.default has type === readonly_field_widget AND
# settings.formatter_type === "string". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_rofw_desc") : NULL;
  $type = $c["type"] ?? NULL;
  $formatter = $c["settings"]["formatter_type"] ?? NULL;
  $ok = ($type === "readonly_field_widget") && ($formatter === "string");
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($type ?? "none") . " formatter_type=" . ($formatter ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
