#!/usr/bin/env bash
# Execution RESET: ensure a namespaced role subreq_legacy_role exists WITH both 'issue
# subrequests' and 'access content' granted, so verify FAILS until the agent revokes just
# 'issue subrequests' (while keeping 'access content'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("subreq_legacy_role")) {
    Role::create(["id" => "subreq_legacy_role", "label" => "Subrequests Legacy Role"])->save();
  }
  user_role_grant_permissions("subreq_legacy_role", ["issue subrequests", "access content"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role subreq_legacy_role has issue subrequests AND access content"
