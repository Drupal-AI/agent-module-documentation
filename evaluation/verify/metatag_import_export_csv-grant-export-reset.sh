#!/usr/bin/env bash
# Execution RESET: ensure role mie_role2 exists WITHOUT the export permission, so verify FAILS
# until the agent grants 'metatag import export csv download'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mie_role2") ?: Role::create(["id" => "mie_role2", "label" => "MIE Role 2"]);
  $r->revokePermission("metatag import export csv download");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role mie_role2 exists without export permission"
