#!/usr/bin/env bash
# Introspection SETUP: the compiler plugin manager service is always registered by the
# compiler module; rebuild caches so the container is fresh, then the agent inspects it.
# No config to write. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: plugin.manager.compiler is registered (inspect its class)"
