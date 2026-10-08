#!/usr/bin/env bash
# Introspection SETUP: ensure role re_repl exists and configure role_expire_default_roles so that
# when re_repl expires the user gets 'authenticated'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("re_repl")) { Role::create(["id" => "re_repl", "label" => "RE Repl"])->save(); }
  \Drupal::configFactory()->getEditable("role_expire.config")
    ->set("role_expire_default_roles", json_encode(["re_repl" => "authenticated"]))->save();
' >/dev/null 2>&1
echo "setup: role_expire.config maps re_repl -> authenticated on expiry"
