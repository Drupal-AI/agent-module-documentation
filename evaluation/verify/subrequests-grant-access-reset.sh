#!/usr/bin/env bash
# Execution RESET: ensure a namespaced role subreq_client_role exists (with an unrelated
# 'access content' permission, as a plausible API-client role) but WITHOUT 'issue
# subrequests', so verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("subreq_client_role")) {
    Role::create(["id" => "subreq_client_role", "label" => "Subrequests Client Role"])->save();
  }
  user_role_grant_permissions("subreq_client_role", ["access content"]);
  user_role_revoke_permissions("subreq_client_role", ["issue subrequests"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role subreq_client_role exists without issue subrequests permission"
