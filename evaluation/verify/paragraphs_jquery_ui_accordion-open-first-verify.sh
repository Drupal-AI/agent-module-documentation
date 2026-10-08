#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pjqa_open accordion formatter has active == 1 (first panel
# open by default). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $c=$vd?$vd->getComponent("field_pjqa_open"):NULL;
  $type=$c["type"]??"none";
  $active=$c["settings"]["active"]??NULL;
  $ok=($type==="paragraphs_jquery_ui_accordion_formatter" && (int)$active===1);
  print ($ok?"PASS":"FAIL")." type=".$type." active=".var_export($active,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
