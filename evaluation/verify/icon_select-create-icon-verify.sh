#!/usr/bin/env bash
# Execution VERIFY: PASS when an 'icons' vocabulary term exists with field_symbol_id=is_task_heart.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $terms = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid" => "icons", "field_symbol_id" => "is_task_heart"]);
  $ok = !empty($terms);
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($terms) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
