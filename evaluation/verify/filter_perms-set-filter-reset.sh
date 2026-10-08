#!/usr/bin/env bash
# Execution RESET: create role fperm_reviewer and clear user 1's filter_perms selection, so verify
# FAILS until the agent stores the requested filter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("fperm_reviewer")) { Role::create(["id" => "fperm_reviewer", "label" => "FPerm Reviewer"])->save(); }
  \Drupal::keyValueExpirable("filter_perms_list")->delete("1");
' >/dev/null 2>&1
echo "reset: role fperm_reviewer present; filter_perms_list[1] cleared"
