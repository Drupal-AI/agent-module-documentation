#!/usr/bin/env bash
# Introspection CLEANUP: delete the ce_recipient commerce_email entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  if ($e = Email::load("ce_recipient")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: commerce_email ce_recipient removed"
