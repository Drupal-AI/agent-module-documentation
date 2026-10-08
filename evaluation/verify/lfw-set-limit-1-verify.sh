#!/usr/bin/env bash
# Execution VERIFY: PASS when field_lfw_single component limit_values === 1. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c=$fd?$fd->getComponent("field_lfw_single"):NULL;
  $v=$c["third_party_settings"]["limited_field_widgets"]["limit_values"]??NULL;
  print ((int)$v===1?"PASS":"FAIL")." limit_values=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
