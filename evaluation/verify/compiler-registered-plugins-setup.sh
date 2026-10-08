#!/usr/bin/env bash
# Introspection SETUP: ensure the compiler plugin registry is discovered. The enabled
# compiler_scss module registers the 'scss' compiler plugin, which the agent must read back
# from the live plugin manager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: compiler plugin manager populated (inspect its registered plugin ids)"
