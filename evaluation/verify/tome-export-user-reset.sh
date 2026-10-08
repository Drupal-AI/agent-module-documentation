#!/usr/bin/env bash
# Execution RESET: remove user 1's Tome Sync content export so verify FAILS until the agent
# re-exports it. user 1 (uuid ae7c2aca-557b-4d70-9483-3bb19e74bb92) already exists. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f content/user.ae7c2aca-557b-4d70-9483-3bb19e74bb92.json
echo "reset: removed content/user.ae7c2aca-557b-4d70-9483-3bb19e74bb92.json (user 1 export cleared)"
