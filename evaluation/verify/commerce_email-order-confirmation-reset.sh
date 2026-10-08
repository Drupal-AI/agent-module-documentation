#!/usr/bin/env bash
# Execution RESET: delete any commerce_email 'ce_confirm' so verify FAILS until the agent creates
# it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  if ($e = Email::load("ce_confirm")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: commerce_email ce_confirm removed"
