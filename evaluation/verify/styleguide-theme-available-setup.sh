#!/usr/bin/env bash
# Introspection SETUP: enable the core 'stark' theme so a per-theme style guide route appears.
set -uo pipefail
cd /var/www/html
drush theme:enable stark -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: theme 'stark' enabled (styleguide.stark route available)"
