#!/usr/bin/env bash
# Execution CLEANUP: remove the storybook_ev_task template dir. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/storybook_ev_task
echo "cleanup: storybook_ev_task removed"
