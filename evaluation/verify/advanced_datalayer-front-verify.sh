#!/usr/bin/env bash
# Execution VERIFY: PASS when the front context's page_Name datalayer tag === 'Homepage'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("front");
  $tags = $d ? $d->get("tags") : [];
  $v = $tags["page_Name"] ?? NULL;
  print (($v === "Homepage") ? "PASS" : "FAIL") . " page_Name=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
