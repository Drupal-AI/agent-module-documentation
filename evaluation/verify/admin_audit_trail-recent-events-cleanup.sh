#!/usr/bin/env bash
# Introspection CLEANUP for admin_audit_trail: remove exactly the rows seeded by
# admin_audit_trail-recent-events-setup.sh (identified by path='eval/audit-trail'), restoring
# the baseline. Leaves all real log rows untouched.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("admin_audit_trail")->condition("path", "eval/audit-trail")->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed seeded eval/audit-trail rows"
