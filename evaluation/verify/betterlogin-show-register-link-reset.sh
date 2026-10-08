#!/usr/bin/env bash
# Execution RESET: set register=admin_only so the register link is HIDDEN and verify FAILS until
# the agent enables anonymous registration. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user.settings")->set("register", "admin_only")->save();' >/dev/null 2>&1
echo "reset: user.settings register=admin_only (register link hidden)"
