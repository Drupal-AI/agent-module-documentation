#!/usr/bin/env bash
# Introspection CLEANUP: remove the known registration_type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  if ($t = RegistrationType::load("reg_known")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: registration.type.reg_known removed"
