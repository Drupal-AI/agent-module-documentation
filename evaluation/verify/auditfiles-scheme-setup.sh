#!/usr/bin/env bash
# Introspection SETUP: point Audit Files at the 'private' scheme so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush config:set auditfiles.settings auditfiles_file_system_path private -y >/dev/null 2>&1
echo "setup: auditfiles_file_system_path=private"
