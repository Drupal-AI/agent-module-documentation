#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dte_setw's component in the Article default form display
# uses the datetime_extras widget datetime_datelist_no_time. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_dte_setw") : NULL;
  $type = $c["type"] ?? NULL;
  $ok = ($type === "datetime_datelist_no_time");
  print ($ok ? "PASS" : "FAIL") . " widget=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
