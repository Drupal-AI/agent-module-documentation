#!/usr/bin/env bash
# Execution CLEANUP: restore global dedupe to the shipped default (0 / off). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set filehash.settings dedupe 0 -y >/dev/null 2>&1
echo "cleanup: filehash.settings dedupe=0 (baseline)"
