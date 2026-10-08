#!/usr/bin/env bash
# Introspection SETUP: make the PRLP new-password field OPTIONAL (password_required=false) so an
# agent can read the current requirement state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("password_required", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: prlp.settings password_required=false"
