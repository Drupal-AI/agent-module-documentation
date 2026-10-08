#!/usr/bin/env bash
# Live-state verification for the "log a node delete event" task.
# PASS (exit 0) when the admin_audit_trail log holds a row with type=node, operation=delete,
# and ref_numeric=4242 (the affected node id). FAIL (exit 1) otherwise. No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n = \Drupal::database()->select("admin_audit_trail", "a")
    ->condition("type", "node")
    ->condition("operation", "delete")
    ->condition("ref_numeric", 4242)
    ->countQuery()->execute()->fetchField();
  print (($n > 0) ? "PASS" : "FAIL") . " rows=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
