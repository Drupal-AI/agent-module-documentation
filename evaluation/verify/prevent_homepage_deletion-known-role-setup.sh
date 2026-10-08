#!/usr/bin/env bash
# Introspection SETUP: create two roles - phd_owner WITH the module's delete_homepage_node
# permission and phd_editor WITHOUT it - so the agent must inspect live role config to say who
# may delete a protected page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $owner = Role::load("phd_owner") ?: Role::create(["id" => "phd_owner", "label" => "PHD Owner"]);
  $owner->grantPermission("delete_homepage_node");
  $owner->grantPermission("delete any article content");
  $owner->save();
  $editor = Role::load("phd_editor") ?: Role::create(["id" => "phd_editor", "label" => "PHD Editor"]);
  $editor->revokePermission("delete_homepage_node");
  $editor->grantPermission("delete any article content");
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role phd_owner has delete_homepage_node, role phd_editor does not"
