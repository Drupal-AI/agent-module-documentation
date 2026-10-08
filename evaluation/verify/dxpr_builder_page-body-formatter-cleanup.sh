#!/usr/bin/env bash
# Introspection CLEANUP: rebuild caches. dxpr_builder_page is left enabled (baseline submodule);
# nothing to tear down. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (dxpr_builder_page remains enabled)"
