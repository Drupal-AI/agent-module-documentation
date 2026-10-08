#!/usr/bin/env bash
# Introspection SETUP: set quiz.settings autotitle_length to a distinctive value (77) so an
# inspecting agent must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset quiz.settings autotitle_length 77 -y >/dev/null 2>&1
echo "setup: quiz.settings autotitle_length = 77"
