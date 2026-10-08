#!/usr/bin/env bash
# Live-state verification for the "write a marker audit-trail entry" task.
# PASS (exit 0) when the admin_audit_trail log contains a row of type `eval` whose description
# includes the exact marker text `AUDIT MARKER OK`. FAIL (exit 1) otherwise. No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = \Drupal::database()->select("admin_audit_trail", "a")
    ->condition("type", "eval")
    ->condition("description", "%AUDIT MARKER OK%", "LIKE")
    ->countQuery()->execute()->fetchField();
  print (($n > 0) ? "PASS" : "FAIL") . " rows=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
