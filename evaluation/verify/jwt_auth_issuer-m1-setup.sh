#!/usr/bin/env bash
# Introspection SETUP: force jwt_auth_issuer.config jwt_in_login_response to FALSE (0), so an
# inspecting agent must read the live value rather than assume the shipped default (true).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset jwt_auth_issuer.config jwt_in_login_response 0 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jwt_auth_issuer.config jwt_in_login_response=0 (false)"
