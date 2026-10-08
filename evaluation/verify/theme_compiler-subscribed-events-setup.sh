#!/usr/bin/env bash
# Introspection SETUP: theme_compiler.compiler is always registered by the module; rebuild
# caches so the container is fresh, then the agent inspects its class. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: theme_compiler.compiler service registered (inspect its class)"
