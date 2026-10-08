#!/usr/bin/env bash
# Introspection SETUP: ensure role mr_known exists and configure a Multiple Registration page for
# it with path alias /join-mr, so an agent can read the alias back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("mr_known")) { Role::create(["id" => "mr_known", "label" => "MR Known"])->save(); }
  \Drupal::configFactory()->getEditable("multiple_registration.create_registration_page_form_config")
    ->set("mr_known", ["path" => "/join-mr", "url" => "/user/register/mr_known", "redirect_path" => "",
      "hidden" => 0, "form_mode_register" => "register", "form_mode_edit" => "default"])->save();
' >/dev/null 2>&1
echo "setup: create_registration_page_form_config.mr_known path=/join-mr"
