#!/usr/bin/env bash
# Introspection CLEANUP: delete the mdu_eval_legacy role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\user\Entity\Role;
  if ($role = Role::load("mdu_eval_legacy")) { $role->delete(); }
' >/dev/null 2>&1

echo "cleanup: role mdu_eval_legacy removed"
