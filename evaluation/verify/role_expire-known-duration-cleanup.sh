#!/usr/bin/env bash
# Introspection CLEANUP: remove the re_known default duration and delete the re_known role.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $c = \Drupal::configFactory()->getEditable("role_expire.config");
  $d = $c->get("role_expire_default_duration_roles") ?: [];
  unset($d["re_known"]);
  $c->set("role_expire_default_duration_roles", $d)->save();
  if ($r = Role::load("re_known")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: re_known role and its default duration removed"
