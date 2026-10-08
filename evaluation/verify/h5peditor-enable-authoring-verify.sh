#!/usr/bin/env bash
# Execution VERIFY: PASS when field_h5pe_task form-display widget type === 'h5p_editor'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_h5pe_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "h5p_editor") ? "PASS" : "FAIL") . " widget=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
