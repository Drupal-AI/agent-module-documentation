#!/usr/bin/env bash
# Execution VERIFY: PASS when field_bsd_task's default form-display widget type is
# bootstrap_date_widget. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_bsd_task") : NULL;
  $type = $c["type"] ?? "none";
  print ($type === "bootstrap_date_widget" ? "PASS" : "FAIL") . " widget=" . $type;
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
