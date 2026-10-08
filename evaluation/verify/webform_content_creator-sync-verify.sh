#!/usr/bin/env bash
# Execution VERIFY: PASS when wcc_edit has sync_content === true (edit synchronization on). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("webform_content_creator")->load("wcc_edit");
  $v = $e ? (bool) $e->get("sync_content") : NULL;
  print (($v === TRUE) ? "PASS" : "FAIL") . " sync_content=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
