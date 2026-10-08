#!/usr/bin/env bash
# Execution VERIFY: PASS when the mta_toggle Activity mapping is enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity")->load("mta_toggle");
  $en = $e ? (bool) $e->enabled : NULL;
  print (($en === TRUE) ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
