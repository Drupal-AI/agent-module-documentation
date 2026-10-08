#!/usr/bin/env bash
# Execution CLEANUP: remove the snippet directory. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/sites/default/files/masonry_eval
echo "cleanup: web/sites/default/files/masonry_eval removed"
