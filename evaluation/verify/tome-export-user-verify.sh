#!/usr/bin/env bash
# Execution VERIFY: PASS when user 1's content export exists and is valid JSON. exit 0/1.
set -uo pipefail
cd /var/www/html
f="content/user.ae7c2aca-557b-4d70-9483-3bb19e74bb92.json"
if [ -s "$f" ] && php -r 'exit(json_decode(file_get_contents($argv[1]))===null?1:0);' "$f" 2>/dev/null; then
  echo "PASS $f exists and is valid JSON"; exit 0
else
  echo "FAIL $f missing or not valid JSON"; exit 1
fi
