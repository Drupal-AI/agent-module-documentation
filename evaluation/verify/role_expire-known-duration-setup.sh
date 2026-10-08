#!/usr/bin/env bash
# Introspection SETUP: ensure role re_known exists and set its Role Expire default duration to
# '3 months' in role_expire.config so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("re_known")) { Role::create(["id" => "re_known", "label" => "RE Known"])->save(); }
  $c = \Drupal::configFactory()->getEditable("role_expire.config");
  $d = $c->get("role_expire_default_duration_roles") ?: [];
  $d["re_known"] = "3 months";
  $c->set("role_expire_default_duration_roles", $d)->save();
' >/dev/null 2>&1
echo "setup: role_expire.config default duration for re_known = 3 months"
