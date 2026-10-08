#!/usr/bin/env bash
# Introspection SETUP: ensure the deprecated mercury_editor_inline_editor module is enabled so an
# inspecting agent can confirm its status and read its deprecation notice. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en mercury_editor_inline_editor -y >/dev/null 2>&1
echo "setup: mercury_editor_inline_editor enabled"
