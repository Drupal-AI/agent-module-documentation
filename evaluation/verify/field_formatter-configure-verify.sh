#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ff_task's component in node.article.default view display
# uses formatter 'field_formatter_from_view_display' with a non-empty settings.field_name.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->loadUnchanged("node.article.default");
  $c=$vd?$vd->getComponent("field_ff_task"):NULL;
  $type=$c["type"]??"none";
  $fn=$c["settings"]["field_name"]??"";
  $ok=($type==="field_formatter_from_view_display" && $fn!=="");
  print ($ok?"PASS":"FAIL")." type=".$type." field_name=".var_export($fn,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
