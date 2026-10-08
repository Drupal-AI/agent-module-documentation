#!/usr/bin/env bash
# Execution VERIFY: PASS only when field_diw_alt has alt_field_required === FALSE AND its
# STORED default form-display component carries
# decorative_image_widget.use_decorative_checkbox === true. Reads raw config. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc=\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_diw_alt");
  $altReq=$fc?$fc->getSetting("alt_field_required"):NULL;
  $c=\Drupal::config("core.entity_form_display.node.article.default")->get("content.field_diw_alt");
  $dec=$c["third_party_settings"]["decorative_image_widget"]["use_decorative_checkbox"] ?? NULL;
  $ok=((bool)$altReq===FALSE && $dec===TRUE);
  print ($ok?"PASS":"FAIL")." alt_required=".var_export($altReq,TRUE)." decorative=".var_export($dec,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
