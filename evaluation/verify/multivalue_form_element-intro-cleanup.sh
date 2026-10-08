#!/usr/bin/env bash
# Introspection CLEANUP (shared): remove the helper module `mfe_intro`. pmu BEFORE rmdir.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu mfe_intro -y >/dev/null 2>&1 || true
rm -rf /var/www/html/web/modules/custom/mfe_intro
drush cr >/dev/null 2>&1
echo "cleanup: mfe_intro uninstalled and directory removed"
