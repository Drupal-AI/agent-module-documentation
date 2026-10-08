#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role mdu_eval_legacy holding ONLY the deprecated
# UI submodule's permission, so the agent has to distinguish it from the Vue browser's
# permission on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("mdu_eval_legacy");
  if (!$role) {
    $role = Role::create(["id" => "mdu_eval_legacy", "label" => "MDU eval legacy"]);
    $role->save();
  }
  $role->grantPermission("access media directories ui browser");
  $role->revokePermission("access media directories browser");
  $role->save();
' >/dev/null 2>&1

echo "setup: role mdu_eval_legacy has 'access media directories ui browser' only"
