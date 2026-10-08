#!/usr/bin/env bash
# Introspection SETUP: create role tc_role and grant it 'have total control' so an agent can read
# back which custom role can see the dashboard. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create tc_role "TC Role" >/dev/null 2>&1 || true
drush role:perm:add tc_role 'have total control' >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "setup: role tc_role has 'have total control'"
