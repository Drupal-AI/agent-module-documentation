#!/usr/bin/env bash
# Introspection SETUP: create role hacked_auditor and grant it Hacked!'s 'view diffs of changed
# files' permission, so an agent can read back which role holds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hacked_auditor") ?: Role::create(["id" => "hacked_auditor", "label" => "Hacked Auditor"]);
  $r->save();
  $r->grantPermission("view diffs of changed files")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role hacked_auditor granted 'view diffs of changed files'"
