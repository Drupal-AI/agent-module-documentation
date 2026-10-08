#!/usr/bin/env bash
# Introspection SETUP: set core user.settings register to admin_only so Better Login would hide
# the register link; the agent must read this value back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user.settings")->set("register", "admin_only")->save();' >/dev/null 2>&1
echo "setup: user.settings register=admin_only"
