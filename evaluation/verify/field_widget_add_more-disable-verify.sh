#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fwam_disable's component no longer has add_more === TRUE
# (turned off / unset) while the field still exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $exists=(bool)FieldConfig::loadByName("node","article","field_fwam_disable");
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c=$fd?$fd->getComponent("field_fwam_disable"):NULL;
  $v=$c["third_party_settings"]["field_widget_add_more"]["add_more"]??NULL;
  $ok=$exists&&($v!==TRUE);
  print ($ok?"PASS":"FAIL")." field_exists=".var_export($exists,TRUE)." add_more=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
