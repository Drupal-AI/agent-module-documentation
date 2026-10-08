#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pjqa_task in node.article default view display uses the
# paragraphs_jquery_ui_accordion_formatter. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $c=$vd?$vd->getComponent("field_pjqa_task"):NULL;
  $type=$c["type"]??"none";
  $ok=($type==="paragraphs_jquery_ui_accordion_formatter");
  print ($ok?"PASS":"FAIL")." type=".$type."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
