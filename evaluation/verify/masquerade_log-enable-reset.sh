#!/usr/bin/env bash
# Execution RESET: uninstall masquerade_log so verify FAILS (logger.dblog would no longer be the
# decorator). NOTE: on this shared site a module uninstall triggers a full container+router
# rebuild that currently cannot complete (unrelated workbench_moderation fatal); run only in a
# healthy environment. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall masquerade_log -y >/dev/null 2>&1 || true
echo "reset: masquerade_log uninstalled (loggers no longer decorated)"
