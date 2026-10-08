#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fdlm_task's formatter component carries
# third_party_settings.field_delimiter.delimiter === " / ".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fdlm_task") : NULL;
  $d = $c["third_party_settings"]["field_delimiter"]["delimiter"] ?? NULL;
  print (($d === " / ") ? "PASS" : "FAIL")." delimiter=".var_export($d, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
