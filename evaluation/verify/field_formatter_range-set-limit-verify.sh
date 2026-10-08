#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ffr_task's component in the default view display has
# third_party_settings.field_formatter_range.limit === 2. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ffr_task") : NULL;
  $limit = $c["third_party_settings"]["field_formatter_range"]["limit"] ?? NULL;
  print (((int)$limit) === 2 ? "PASS" : "FAIL") . " limit=" . var_export($limit, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
