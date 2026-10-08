#!/usr/bin/env bash
# Introspection SETUP: ensure caches/plugin definitions are current so the agent can list the
# registered Styleguide plugins from the live plugin manager. (No site mutation.)
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches rebuilt; plugin.manager.styleguide definitions current"
