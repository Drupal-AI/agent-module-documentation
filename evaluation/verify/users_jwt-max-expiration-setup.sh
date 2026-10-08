#!/usr/bin/env bash
# Introspection SETUP: set users_jwt.config max_expiration to a known value
# (7200) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset users_jwt.config max_expiration 7200 >/dev/null 2>&1
echo "setup: users_jwt.config max_expiration=7200"
