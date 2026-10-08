#!/usr/bin/env bash
# Introspection CLEANUP: delete login_redirect_per_role.settings entirely, restoring the
# shipped baseline (module ships no config/install default -> object absent). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("login_redirect_per_role.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: login_redirect_per_role.settings deleted (baseline)"
