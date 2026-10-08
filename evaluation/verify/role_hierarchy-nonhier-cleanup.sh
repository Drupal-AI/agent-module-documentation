#!/usr/bin/env bash
# Introspection CLEANUP: delete role rh_free and remove the role_hierarchy.settings config
# (restores the baseline where the config does not exist). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("rh_free")) { $r->delete(); }
  $c = \Drupal::configFactory()->getEditable("role_hierarchy.settings");
  if (!$c->isNew()) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rh_free removed, role_hierarchy.settings deleted"
