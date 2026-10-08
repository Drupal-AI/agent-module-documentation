#!/usr/bin/env bash
# Execution RESET: ensure the target registration_type does NOT exist, so verify fails on empty
# state until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  if ($t = RegistrationType::load("reg_build")) { $t->delete(); }
' >/dev/null 2>&1
echo "reset: registration.type.reg_build absent"
