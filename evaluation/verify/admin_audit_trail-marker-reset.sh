#!/usr/bin/env bash
# Execution RESET for the "write a marker audit-trail entry" task. Clears any pre-existing
# `eval`-type rows so an un-built site verifies as FAIL, guaranteeing each run starts empty.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("admin_audit_trail")->condition("type", "eval")->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cleared type=eval audit-trail rows"
