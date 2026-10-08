#!/usr/bin/env bash
# Execution CLEANUP: remove re_task default duration and delete the re_task role. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $c = \Drupal::configFactory()->getEditable("role_expire.config");
  $d = $c->get("role_expire_default_duration_roles") ?: [];
  unset($d["re_task"]);
  $c->set("role_expire_default_duration_roles", $d)->save();
  if ($r = Role::load("re_task")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: re_task role and its default duration removed"
