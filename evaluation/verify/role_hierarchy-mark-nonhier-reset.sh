#!/usr/bin/env bash
# Execution RESET: create a namespaced role rh_bypass and ensure role_hierarchy.settings does
# NOT list it as non-hierarchical (verify FAILS until the agent adds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("rh_bypass")) { Role::create(["id"=>"rh_bypass","label"=>"RH Bypass Role"])->save(); }
  \Drupal::configFactory()->getEditable("role_hierarchy.settings")
    ->set("non_hierarchical_roles", [])->set("invert", FALSE)->set("strict", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role rh_bypass present, not yet non-hierarchical"
