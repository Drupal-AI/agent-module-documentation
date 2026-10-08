#!/usr/bin/env bash
# Execution RESET for the "log a node delete event" task. Removes any prior audit-trail row
# that references node 4242, so the verify starts from empty state (FAIL until built).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("admin_audit_trail")
    ->condition("type", "node")->condition("ref_numeric", 4242)->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cleared node/ref_numeric=4242 audit-trail rows"
