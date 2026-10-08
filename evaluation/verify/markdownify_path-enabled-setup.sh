#!/usr/bin/env bash
# Introspection SETUP: ensure the markdownify_path submodule is enabled so an inspecting agent
# can confirm alias-based .md access is available on this site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en markdownify_path -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: markdownify_path enabled"
