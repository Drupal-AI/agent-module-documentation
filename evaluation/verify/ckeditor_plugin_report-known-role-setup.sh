#!/usr/bin/env bash
# Introspection SETUP: create role ckpr_reviewer and grant it 'view ckeditor plugin report'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ckpr_reviewer") ?: Role::create(["id" => "ckpr_reviewer", "label" => "CKPR Reviewer"]);
  $r->grantPermission("view ckeditor plugin report")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role ckpr_reviewer granted 'view ckeditor plugin report'"
