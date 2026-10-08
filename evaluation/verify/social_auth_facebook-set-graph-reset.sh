#!/usr/bin/env bash
# Execution RESET: delete social_auth_facebook.settings so graph_version is absent and verify
# FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_facebook.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: social_auth_facebook.settings deleted (graph_version absent)"
