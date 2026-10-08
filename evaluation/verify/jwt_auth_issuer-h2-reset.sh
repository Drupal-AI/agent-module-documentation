#!/usr/bin/env bash
# Execution RESET: force baseline FALSE (jwt_in_login_response=0). The task asks the agent to
# turn it ON, so verify must FAIL against this reset state until the agent acts. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset jwt_auth_issuer.config jwt_in_login_response 0 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jwt_auth_issuer.config jwt_in_login_response=0 (false, baseline)"
