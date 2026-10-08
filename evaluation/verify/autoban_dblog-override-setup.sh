#!/usr/bin/env bash
# Introspection SETUP (autoban_dblog): ensure autoban_dblog is enabled so the dblog.overview
# route is served by Autoban's controller, which an agent can then read off the live router.
# (drush en may time out client-side under load but still succeed; the override is what matters.)
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en autoban_dblog -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1 || true
echo "setup: autoban_dblog enabled (dblog.overview overridden)"
