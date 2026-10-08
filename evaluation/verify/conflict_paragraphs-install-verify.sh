#!/usr/bin/env bash
# Execution VERIFY: PASS when conflict_paragraphs is installed AND its FieldComparator plugin
# conflict_field_comparator_paragraph_ref is registered. Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $on = \Drupal::moduleHandler()->moduleExists("conflict_paragraphs");
  $defs = \Drupal::service("conflict.field_comparator.manager")->getDefinitions();
  $has = isset($defs["conflict_field_comparator_paragraph_ref"]);
  $ok = $on && $has;
  print ($ok ? "PASS" : "FAIL") . " installed=" . var_export($on, TRUE) . " plugin=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
