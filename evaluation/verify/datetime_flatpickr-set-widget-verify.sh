#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dtf_task widget type is datetime_flatpickr. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_dtf_task") : NULL;
  $ok = ($c["type"] ?? "") === "datetime_flatpickr";
  print ($ok ? "PASS" : "FAIL") . " type=" . ($c["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
