#!/usr/bin/env bash
# Execution RESET: remove all login_redirect_per_role config so no logout redirect exists
# (verify then FAILs until the agent builds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("login_redirect_per_role.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: login_redirect_per_role.settings deleted"
