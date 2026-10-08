#!/usr/bin/env bash
# Execution RESET: ensure the compiler_probe module and its directory are ABSENT so the
# 'probe_compiler' compiler plugin is not registered (verify must FAIL on this empty state).
# Uninstalls the module BEFORE removing its directory to avoid an orphaned module. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu compiler_probe -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/compiler_probe
drush cr >/dev/null 2>&1
echo "reset: compiler_probe uninstalled and directory removed"
