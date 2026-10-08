#!/usr/bin/env bash
# Introspection CLEANUP: clear the replacement mapping and delete role re_repl. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("role_expire.config")->set("role_expire_default_roles", "")->save();
  if ($r = Role::load("re_repl")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: re_repl role and replacement mapping removed"
