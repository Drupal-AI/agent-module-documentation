#!/usr/bin/env bash
# Introspection SETUP: set post-reset redirect to /node/add.
set -uo pipefail
cd /var/www/html
drush config:set simple_pass_reset.settings login_redirection '/node/add' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: login_redirection = /node/add"
