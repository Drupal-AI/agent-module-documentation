#!/usr/bin/env bash
# Execution VERIFY: PASS when field_erp_qtask has entity_reference_purger.use_queue === true
# (and remove_orphaned still true). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("field.field.node.article.field_erp_qtask");
  $uq = $c->get("third_party_settings.entity_reference_purger.use_queue");
  $ro = $c->get("third_party_settings.entity_reference_purger.remove_orphaned");
  $ok = ($uq === TRUE && $ro === TRUE);
  print ($ok ? "PASS" : "FAIL") . " remove_orphaned=" . var_export($ro, TRUE) . " use_queue=" . var_export($uq, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
