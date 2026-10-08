#!/usr/bin/env bash
# Execution RESET: ensure role mie_role exists WITHOUT the import permission, so verify FAILS
# until the agent grants 'metatag import export csv upload'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("mie_role") ?: Role::create(["id" => "mie_role", "label" => "MIE Role"]);
  $r->revokePermission("metatag import export csv upload");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role mie_role exists without import permission"
