#!/usr/bin/env bash
# Introspection SETUP: create two namespaced roles, subreq_role_on (granted 'issue
# subrequests') and subreq_role_off (exists, but not granted it), so an inspecting agent must
# read back live role permissions to tell them apart. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("subreq_role_on")) {
    Role::create(["id" => "subreq_role_on", "label" => "Subrequests Role On"])->save();
  }
  if (!Role::load("subreq_role_off")) {
    Role::create(["id" => "subreq_role_off", "label" => "Subrequests Role Off"])->save();
  }
  user_role_grant_permissions("subreq_role_on", ["issue subrequests"]);
  user_role_revoke_permissions("subreq_role_off", ["issue subrequests"]);
  user_role_grant_permissions("subreq_role_off", ["access content"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: subreq_role_on has issue subrequests; subreq_role_off does not"
