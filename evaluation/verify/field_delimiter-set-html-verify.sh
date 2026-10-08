#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fdlm_list's formatter delimiter is exactly "<br>".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fdlm_list") : NULL;
  $d = $c["third_party_settings"]["field_delimiter"]["delimiter"] ?? NULL;
  print (($d === "<br>") ? "PASS" : "FAIL")." delimiter=".var_export($d, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
