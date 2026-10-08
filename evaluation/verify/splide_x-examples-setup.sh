#!/usr/bin/env bash
# Introspection SETUP: ensure splide_x is enabled so its example optionsets/config are present. Idempotent.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx splide_x; then
  drush en splide_x -y >/dev/null 2>&1 || true
fi
echo "setup: splide_x enabled (example optionsets present)"
