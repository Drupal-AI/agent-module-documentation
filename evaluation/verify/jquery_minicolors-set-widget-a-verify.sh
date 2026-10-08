#!/usr/bin/env bash
# Execution VERIFY: PASS when field_jqmc_task component widget type === 'jquery_minicolors_widget'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_jqmc_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "jquery_minicolors_widget") ? "PASS" : "FAIL") . " type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
