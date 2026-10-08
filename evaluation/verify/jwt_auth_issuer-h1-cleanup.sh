#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default jwt_in_login_response=1 (true). Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset jwt_auth_issuer.config jwt_in_login_response 1 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jwt_auth_issuer.config jwt_in_login_response restored to 1 (true)"
