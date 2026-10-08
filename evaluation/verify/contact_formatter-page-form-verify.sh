#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cfmt_page on node.page.default renders via
# contact_field_formatter. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.page.default");
  $c = $vd ? $vd->getComponent("field_cfmt_page") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "contact_field_formatter") ? "PASS" : "FAIL") . " formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
