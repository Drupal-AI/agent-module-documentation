#!/usr/bin/env bash
# PASS when sfe_ttask has a hardcoded field mapping whose salesforce_field is LeadSource. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfe_ttask");
  $ok = FALSE;
  if ($m) { foreach (($m->get("field_mappings") ?: []) as $fm) { if (($fm["drupal_field_type"] ?? "") === "hardcoded" && ($fm["salesforce_field"] ?? "") === "LeadSource") { $ok = TRUE; } } }
  print (($ok) ? "PASS" : "FAIL") . " hardcoded_leadsource=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
