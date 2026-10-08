#!/usr/bin/env bash
# PASS when sfe_task exists AND has a field mapping using the hardcoded field plugin. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfe_task");
  $has = FALSE;
  if ($m) { foreach (($m->get("field_mappings") ?: []) as $fm) { if (($fm["drupal_field_type"] ?? "") === "hardcoded") { $has = TRUE; } } }
  print (($m && $has) ? "PASS" : "FAIL") . " hardcoded_field=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
