#!/usr/bin/env bash
# Execution RESET: ensure roles re_task and re_after exist and clear any Role Expire
# replacement-role mapping (so verify FAILS until the agent maps re_task -> re_after).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("re_task")) { Role::create(["id" => "re_task", "label" => "RE Task"])->save(); }
  if (!Role::load("re_after")) { Role::create(["id" => "re_after", "label" => "RE After"])->save(); }
  \Drupal::configFactory()->getEditable("role_expire.config")->set("role_expire_default_roles", "")->save();
' >/dev/null 2>&1
echo "reset: roles re_task and re_after present, replacement mapping cleared"
