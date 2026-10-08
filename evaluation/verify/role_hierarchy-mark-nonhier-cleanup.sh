#!/usr/bin/env bash
# Execution CLEANUP: delete role rh_bypass and remove role_hierarchy.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("rh_bypass")) { $r->delete(); }
  $c = \Drupal::configFactory()->getEditable("role_hierarchy.settings");
  if (!$c->isNew()) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rh_bypass removed, role_hierarchy.settings deleted"
