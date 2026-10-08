#!/usr/bin/env bash
# Execution RESET: ensure workflowfield is INSTALLED so verify (which wants it gone) FAILS until the
# agent uninstalls it.
set -uo pipefail
cd /var/www/html
drush en workflowfield -y >/dev/null 2>&1
echo "reset: workflowfield installed"
