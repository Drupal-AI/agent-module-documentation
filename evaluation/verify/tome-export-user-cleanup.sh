#!/usr/bin/env bash
# Execution CLEANUP: remove user 1's content export to restore baseline. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f content/user.ae7c2aca-557b-4d70-9483-3bb19e74bb92.json
echo "cleanup: removed content/user.ae7c2aca-557b-4d70-9483-3bb19e74bb92.json"
