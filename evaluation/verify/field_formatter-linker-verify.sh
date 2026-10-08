#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ff_str's component in node.article.default view display
# uses the field_formatter "Field linker" formatter (type === field_link). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->loadUnchanged("node.article.default");
  $c=$vd?$vd->getComponent("field_ff_str"):NULL;
  $type=$c["type"]??"none";
  $ok=($type==="field_link");
  print ($ok?"PASS":"FAIL")." type=".$type."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
