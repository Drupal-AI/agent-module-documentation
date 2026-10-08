#!/usr/bin/env bash
# Execution CLEANUP: delete the ce_admin_paid commerce_email entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  if ($e = Email::load("ce_admin_paid")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: commerce_email ce_admin_paid removed"
