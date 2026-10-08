#!/usr/bin/env bash
# Execution CLEANUP: remove the mr_task registration page config and the mr_task role. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("multiple_registration.create_registration_page_form_config")->clear("mr_task")->save();
  if ($r = Role::load("mr_task")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: mr_task role and registration page config removed"
