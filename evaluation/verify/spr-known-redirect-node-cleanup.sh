#!/usr/bin/env bash
# Introspection CLEANUP: restore login_redirection default /user.
set -uo pipefail
cd /var/www/html
drush config:set simple_pass_reset.settings login_redirection '/user' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: login_redirection = /user"
