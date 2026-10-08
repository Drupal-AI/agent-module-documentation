#!/usr/bin/env bash
# Introspection CLEANUP: delete social_auth_facebook.settings to restore baseline (absent, the
# module ships no config/install). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_facebook.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: social_auth_facebook.settings deleted (baseline)"
