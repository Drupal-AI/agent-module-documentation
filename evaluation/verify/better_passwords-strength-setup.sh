#!/usr/bin/env bash
# Introspection SETUP: set a known minimum strength (4 = Strongest) and auto_generate=2
# (Required) so an inspecting agent can read the live policy back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cset better_passwords.settings strength 4 >/dev/null 2>&1
drush -y cset better_passwords.settings auto_generate 2 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: better_passwords.settings strength=4 auto_generate=2"
