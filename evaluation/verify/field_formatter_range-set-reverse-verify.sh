#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ffr_period's component has
# third_party_settings.field_formatter_range.order === 1 (Reverse). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ffr_period") : NULL;
  $order = $c["third_party_settings"]["field_formatter_range"]["order"] ?? NULL;
  print (((int)$order) === 1 ? "PASS" : "FAIL") . " order=" . var_export($order, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
