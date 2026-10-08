#!/usr/bin/env bash
# Introspection CLEANUP: remove node 1's content export to restore baseline. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f content/node.5528817f-2211-4569-91a2-af6f5da9da25.json
echo "cleanup: removed content/node.5528817f-2211-4569-91a2-af6f5da9da25.json"
