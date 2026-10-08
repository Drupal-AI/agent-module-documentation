#!/usr/bin/env bash
# Introspection SETUP: set jwt_path_auth.config allowed_path_prefixes to a single non-default
# prefix, so an inspecting agent must read the live config to name it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jwt_path_auth.config")
    ->set("allowed_path_prefixes", ["/jwtpa-report/"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jwt_path_auth.config allowed_path_prefixes=[/jwtpa-report/]"
