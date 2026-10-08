#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role mdb_eval_curator and grant it exactly the
# media_directories_browser permission, so an inspecting agent must find which permission
# gates the browser and which role holds it on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("mdb_eval_curator");
  if (!$role) {
    $role = Role::create(["id" => "mdb_eval_curator", "label" => "MDB eval curator"]);
    $role->save();
  }
  $role->grantPermission("access media directories browser");
  $role->save();
' >/dev/null 2>&1

echo "setup: role mdb_eval_curator has 'access media directories browser'"
