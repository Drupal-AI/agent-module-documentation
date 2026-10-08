#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c=$fd?$fd->getComponent("field_ebt_task2"):NULL;
  $s=$c["settings"]["additional_fields"]["options"]["status"]??NULL;
  $ok=($c && $c["type"]==="entity_reference_browser_table_widget" && !empty($s));
  print ($ok?"PASS":"FAIL")." status=".var_export($s,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
