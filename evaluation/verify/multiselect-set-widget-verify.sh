#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ms_task component widget type === 'multiselect'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ms_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "multiselect") ? "PASS" : "FAIL") . " type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
