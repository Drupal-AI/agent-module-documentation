#!/usr/bin/env bash
# Execution RESET: ensure workflow_devel is INSTALLED so verify (which wants it gone) FAILS until the
# agent uninstalls it.
set -uo pipefail
cd /var/www/html
drush en workflow_devel -y >/dev/null 2>&1
echo "reset: workflow_devel installed"
