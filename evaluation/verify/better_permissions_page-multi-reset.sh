#!/usr/bin/env bash
# Execution RESET: ensure role bpp_multi exists WITHOUT the two target permissions
# ('access site reports' and 'view the administration theme') so verify FAILS until both are
# granted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("bpp_multi")) { $r->delete(); }
  Role::create(["id" => "bpp_multi", "label" => "BPP Multi"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role bpp_multi present with no extra permissions"
