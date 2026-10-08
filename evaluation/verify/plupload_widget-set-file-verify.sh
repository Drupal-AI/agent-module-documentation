#!/usr/bin/env bash
# Execution VERIFY: PASS when field_plw_task's form-display widget is plupload_file_widget.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_plw_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "plupload_file_widget");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
