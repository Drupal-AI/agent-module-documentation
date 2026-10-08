#!/usr/bin/env bash
# Introspection SETUP: compiler_scss has no per-site config, so this only ensures the plugin
# registry / container is built so the agent can inspect the live 'scss' plugin and
# compiler_scss.backend service. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches rebuilt; scss compiler plugin + compiler_scss.backend discoverable live"
