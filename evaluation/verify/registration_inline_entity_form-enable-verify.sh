#!/usr/bin/env bash
# PASS when node.article field_reg_ief uses the inline_entity_form_settings widget. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_reg_ief") : NULL;
  $t = $c["type"] ?? "none";
  print (($t==="inline_entity_form_settings")?"PASS":"FAIL")." widget=".$t."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
