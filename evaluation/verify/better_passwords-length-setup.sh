#!/usr/bin/env bash
# Introspection SETUP: set Better Passwords minimum length to a known value (16) so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset better_passwords.settings length 16 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: better_passwords.settings length=16"
