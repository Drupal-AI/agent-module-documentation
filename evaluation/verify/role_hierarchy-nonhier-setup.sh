#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role rh_free and mark it non-hierarchical in
# role_hierarchy.settings, so the agent must inspect the config to find which role is excluded
# from the hierarchy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("rh_free")) { Role::create(["id"=>"rh_free","label"=>"RH Free Role"])->save(); }
  \Drupal::configFactory()->getEditable("role_hierarchy.settings")
    ->set("non_hierarchical_roles", ["rh_free" => "rh_free"])
    ->set("invert", FALSE)->set("strict", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role rh_free set as non_hierarchical in role_hierarchy.settings"
