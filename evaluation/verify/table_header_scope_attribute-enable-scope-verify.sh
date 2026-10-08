#!/usr/bin/env bash
# Execution VERIFY: PASS when the scope-attribute filter is enabled on format thsa_exec.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("thsa_exec");
  $on = FALSE;
  if ($f && ($flt = $f->filters("table_header_scope_attribute")) && $flt->status) { $on = TRUE; }
  print ($on ? "PASS" : "FAIL") . " thsa_exec scope_filter=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
