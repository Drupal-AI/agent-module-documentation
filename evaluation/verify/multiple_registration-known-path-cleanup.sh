#!/usr/bin/env bash
# Introspection CLEANUP: remove the mr_known registration page config and the mr_known role.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $c = \Drupal::configFactory()->getEditable("multiple_registration.create_registration_page_form_config");
  $c->clear("mr_known")->save();
  if ($r = Role::load("mr_known")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: mr_known role and registration page config removed"
