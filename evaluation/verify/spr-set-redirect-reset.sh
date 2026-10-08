#!/usr/bin/env bash
# Execution RESET: restore login_redirection to /user so verify FAILS until changed.
set -uo pipefail
cd /var/www/html
drush config:set simple_pass_reset.settings login_redirection '/user' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: login_redirection = /user"
