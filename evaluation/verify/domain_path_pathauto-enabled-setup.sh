#!/usr/bin/env bash
# Introspection SETUP: ensure the domain_path_pathauto submodule is enabled so its Pathauto
# service decorators are active on the live container for the agent to inspect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx domain_path_pathauto; then
  drush en domain_path_pathauto -y >/dev/null 2>&1
fi
echo "setup: domain_path_pathauto enabled (pathauto services decorated)"
