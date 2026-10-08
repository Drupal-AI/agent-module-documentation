#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role subreq_role_partner and grant it the
# 'issue subrequests' permission, so an inspecting agent can read back which role has API
# batching access. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("subreq_role_partner")) {
    Role::create(["id" => "subreq_role_partner", "label" => "Subrequests Partner API Role"])->save();
  }
  user_role_grant_permissions("subreq_role_partner", ["issue subrequests"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role subreq_role_partner has issue subrequests permission"
