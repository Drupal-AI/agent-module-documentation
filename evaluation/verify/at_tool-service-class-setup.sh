#!/usr/bin/env bash
# Introspection SETUP: ensure the container is built so the at_tool.lazy_builders service is
# discoverable. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches cleared; at_tool.lazy_builders service available"
