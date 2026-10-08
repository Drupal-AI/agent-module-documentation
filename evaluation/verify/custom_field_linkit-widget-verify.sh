#!/usr/bin/env bash
# VERIFY: PASS when field_cf_lk "cta" subfield uses the linkit widget. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.cf_lk_eval.default");
  $c=$fd?$fd->getComponent("field_cf_lk"):NULL; $w=$c["settings"]["fields"]["cta"]["type"]??"none";
  print (($w==="linkit")?"PASS":"FAIL")." subfield_widget=".$w."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
