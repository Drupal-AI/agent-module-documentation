#!/usr/bin/env bash
# Introspection CLEANUP: remove the storybook_ev_data template dir. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/storybook_ev_data
echo "cleanup: storybook_ev_data removed"
