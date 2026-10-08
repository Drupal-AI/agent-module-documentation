#!/usr/bin/env bash
# Execution RESET: ensure role mr_task exists and has NO Multiple Registration page config (so
# verify FAILS until the agent creates one). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("mr_task")) { Role::create(["id" => "mr_task", "label" => "MR Task"])->save(); }
  \Drupal::configFactory()->getEditable("multiple_registration.create_registration_page_form_config")->clear("mr_task")->save();
' >/dev/null 2>&1
echo "reset: role mr_task present, no registration page config"
