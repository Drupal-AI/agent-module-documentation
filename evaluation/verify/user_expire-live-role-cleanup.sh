#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped baseline (empty user_expire_roles). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("user_expire.settings")->set("user_expire_roles", [])->save();
' >/dev/null 2>&1
echo "cleanup: user_expire_roles={} (baseline)"
