#!/usr/bin/env bash
# Execution RESET (hard): remove the generic-export output directory so verify FAILs on empty
# state. The agent is expected to (re)create it with `drush config:export --generic`. Exits 0.
set -uo pipefail
cd /var/www/html
rm -rf /var/www/html/web/sites/default/files/eval-generic-export
echo "reset: /var/www/html/web/sites/default/files/eval-generic-export removed"
