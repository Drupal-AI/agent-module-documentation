#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default retain_changed_date=1 explicitly.
set -uo pipefail
cd /var/www/html
drush cset field_defaults.settings retain_changed_date 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_defaults.settings retain_changed_date=1 (shipped default)"
