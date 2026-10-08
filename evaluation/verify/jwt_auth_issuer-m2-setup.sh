#!/usr/bin/env bash
# Introspection SETUP: explicitly (re)save jwt_auth_issuer.config jwt_in_login_response=1
# (true), so an inspecting agent confirms the live ON state rather than assuming it. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset jwt_auth_issuer.config jwt_in_login_response 1 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jwt_auth_issuer.config jwt_in_login_response=1 (true, explicit)"
