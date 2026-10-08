#!/usr/bin/env bash
# Introspection SETUP: ensure cloudflarepurger enabled so the purge purger plugin is registered.
set -uo pipefail
cd /var/www/html
drush en cloudflarepurger -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cloudflarepurger enabled; purge purger definitions current"
