#!/usr/bin/env bash
# Execution RESET: delete the snippet directory web/sites/default/files/masonry_eval so verify
# FAILS on empty state until the agent writes apply.php. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/sites/default/files/masonry_eval
echo "reset: web/sites/default/files/masonry_eval removed"
