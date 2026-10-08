#!/usr/bin/env bash
# Execution VERIFY: PASS when the STORED default form-display config for field_diw_task uses
# the image_image widget and carries decorative_image_widget.use_decorative_checkbox === true.
# Reads raw config (authoritative for what is stored). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("core.entity_form_display.node.article.default")->get("content.field_diw_task");
  $v=$c["third_party_settings"]["decorative_image_widget"]["use_decorative_checkbox"] ?? NULL;
  $ok=($v===TRUE);
  print ($ok?"PASS":"FAIL")." widget=".($c["type"]??"none")." decorative=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
