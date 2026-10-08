#!/usr/bin/env bash
# Execution VERIFY: PASS when a rate_widget 'rate_task' exists and is attached to the
# node.article bundle (entity_types contains node.article). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("rate_widget")->load("rate_task");
  $types = $w ? array_values((array) $w->get("entity_types")) : [];
  $ok = $w && in_array("node.article", $types, TRUE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $w, TRUE) . " entity_types=" . implode("|", $types) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
