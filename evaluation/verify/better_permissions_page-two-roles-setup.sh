#!/usr/bin/env bash
# Introspection SETUP: create roles bpp_alpha (perm 'access site reports') and bpp_beta
# (perm 'view the administration theme'); the agent must inspect the live roles to say which
# one can access site reports. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("bpp_alpha")) { Role::create(["id" => "bpp_alpha", "label" => "BPP Alpha"])->save(); }
  if (!Role::load("bpp_beta")) { Role::create(["id" => "bpp_beta", "label" => "BPP Beta"])->save(); }
  user_role_grant_permissions("bpp_alpha", ["access site reports"]);
  user_role_grant_permissions("bpp_beta", ["view the administration theme"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: bpp_alpha=access site reports, bpp_beta=view the administration theme"
