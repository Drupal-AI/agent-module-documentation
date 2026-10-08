#!/usr/bin/env bash
# Execution CLEANUP: delete the ce_confirm commerce_email entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  if ($e = Email::load("ce_confirm")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: commerce_email ce_confirm removed"
