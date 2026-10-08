#!/usr/bin/env bash
# Execution RESET: remove node 1's content export so verify FAILS until the agent re-exports it.
# node 1 (uuid 5528817f-2211-4569-91a2-af6f5da9da25) already exists. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f content/node.5528817f-2211-4569-91a2-af6f5da9da25.json
echo "reset: removed content/node.5528817f-2211-4569-91a2-af6f5da9da25.json"
