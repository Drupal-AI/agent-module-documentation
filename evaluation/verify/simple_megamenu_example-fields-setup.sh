#!/usr/bin/env bash
# Introspection SETUP: ensure the simple_megamenu_example submodule is enabled so its shipped
# 'megamenu' bundle and fields are present for the agent to inspect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx simple_megamenu_example; then
  drush en simple_megamenu_example -y >/dev/null 2>&1
fi
echo "setup: simple_megamenu_example enabled (megamenu bundle + fields present)"
