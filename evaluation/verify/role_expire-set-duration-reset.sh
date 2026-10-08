#!/usr/bin/env bash
# Execution RESET: ensure role re_task exists and has NO Role Expire default duration (so verify
# FAILS until the agent sets it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("re_task")) { Role::create(["id" => "re_task", "label" => "RE Task"])->save(); }
  $c = \Drupal::configFactory()->getEditable("role_expire.config");
  $d = $c->get("role_expire_default_duration_roles") ?: [];
  unset($d["re_task"]);
  $c->set("role_expire_default_duration_roles", $d)->save();
' >/dev/null 2>&1
echo "reset: role re_task present with no default duration"
