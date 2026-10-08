#!/usr/bin/env bash
# Introspection SETUP: create a role tls_eval_role granted 'use toolbar_language_switcher' so an
# agent can discover which role may use the switcher. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tls_eval_role") ?: Role::create(["id" => "tls_eval_role", "label" => "TLS Eval Role"]);
  $r->grantPermission("use toolbar_language_switcher");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role tls_eval_role has use toolbar_language_switcher"
