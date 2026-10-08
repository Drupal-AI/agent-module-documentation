#!/usr/bin/env bash
# Execution VERIFY: PASS when the key/value watermark last_id === 5 for cse_feedback.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::keyValue("contact_storage_export.cse_feedback")->get("last_id");
  $ok = ((int) $v === 5 && $v !== NULL);
  print ($ok ? "PASS" : "FAIL") . " last_id=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
