#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ebt_task's default form-display component uses the
# entity_reference_browser_table_widget. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ebt_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_browser_table_widget");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
