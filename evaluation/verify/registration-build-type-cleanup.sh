#!/usr/bin/env bash
# Execution CLEANUP: remove the built registration_type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  if ($t = RegistrationType::load("reg_build")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: registration.type.reg_build removed"
