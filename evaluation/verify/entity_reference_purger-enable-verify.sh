#!/usr/bin/env bash
# Execution VERIFY: PASS when field_erp_task has entity_reference_purger.remove_orphaned === true.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ro = \Drupal::config("field.field.node.article.field_erp_task")->get("third_party_settings.entity_reference_purger.remove_orphaned");
  $ok = ($ro === TRUE);
  print ($ok ? "PASS" : "FAIL") . " remove_orphaned=" . var_export($ro, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
