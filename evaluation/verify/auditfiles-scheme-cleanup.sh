#!/usr/bin/env bash
# CLEANUP: restore the shipped default scheme (public). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set auditfiles.settings auditfiles_file_system_path public -y >/dev/null 2>&1
echo "cleanup: auditfiles_file_system_path restored to public"
