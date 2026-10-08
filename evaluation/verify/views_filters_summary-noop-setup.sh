#!/usr/bin/env bash
# Introspection SETUP (shared by the views_filters_summary submodule cases): no config is planted.
# The facts under test (a submodule's declared companion dependency and the alter hook it
# implements) are read from the live module registry / on-disk extension info, which needs no
# mutation. Just rebuild caches so the registry is fresh. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches rebuilt; inspect the module registry / extension info"
