#!/usr/bin/env bash
# Introspection SETUP: ensure the markdownify_views submodule is enabled so an inspecting agent
# can confirm Views-page Markdown routes are being generated on this site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en markdownify_views -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: markdownify_views enabled"
