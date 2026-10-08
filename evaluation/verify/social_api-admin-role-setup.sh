#!/usr/bin/env bash
# Introspection SETUP: create two roles and give each ONE social_api permission, so the agent
# must inspect the live site to say which role may reach /admin/config/social-api.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach ([
    "social_api_eval_admin" => ["label" => "Social API eval admin", "perm" => "administer social api configuration"],
    "social_api_eval_poster" => ["label" => "Social API eval poster", "perm" => "administer social api autoposting"],
  ] as $id => $info) {
    $role = Role::load($id) ?: Role::create(["id" => $id, "label" => $info["label"]]);
    $role->grantPermission($info["perm"]);
    $role->save();
  }
' >/dev/null 2>&1
echo "setup: roles social_api_eval_admin (configuration) and social_api_eval_poster (autoposting) created"
