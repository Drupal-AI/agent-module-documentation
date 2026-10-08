#!/usr/bin/env bash
# Introspection SETUP: create a custom role potx_translator granted 'translate interface' (the
# permission that gates potx's Extract page), so an agent can read back which role can use potx.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("potx_translator");
  if (!$r) {
    $r = Role::create(["id" => "potx_translator", "label" => "Potx Translator"]);
    $r->save();
  }
  $r->grantPermission("translate interface");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role potx_translator granted 'translate interface'"
