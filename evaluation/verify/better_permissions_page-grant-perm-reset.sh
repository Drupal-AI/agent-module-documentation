#!/usr/bin/env bash
# Execution RESET: ensure role bpp_task exists with NO extra permissions and specifically
# WITHOUT 'access site reports' (so verify FAILS until the agent grants it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("bpp_task")) { $r->delete(); }
  Role::create(["id" => "bpp_task", "label" => "BPP Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role bpp_task present with no extra permissions"
