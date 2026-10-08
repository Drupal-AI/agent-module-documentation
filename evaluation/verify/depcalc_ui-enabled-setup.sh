#!/usr/bin/env bash
# Introspection SETUP: ensure depcalc_ui is enabled (no-op if already). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx depcalc_ui || drush en depcalc_ui -y >/dev/null 2>&1
echo "setup: depcalc_ui enabled"
