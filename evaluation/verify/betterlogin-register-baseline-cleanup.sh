#!/usr/bin/env bash
# Execution CLEANUP: restore baseline user.settings register=visitors. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user.settings")->set("register", "visitors")->save();' >/dev/null 2>&1
echo "cleanup: user.settings register=visitors (baseline)"
