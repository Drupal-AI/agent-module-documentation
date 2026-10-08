#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article.default form display sets field_ieftvm_h1's widget to
# inline_entity_form_complex_table_view_mode. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ieftvm_h1") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "inline_entity_form_complex_table_view_mode") ? "PASS" : "FAIL") . " type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
