#!/usr/bin/env bash
# Introspection CLEANUP: restore plupload's shipped default temporary_uri. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset plupload.settings temporary_uri 'temporary://' -y >/dev/null 2>&1
echo "cleanup: plupload.settings temporary_uri = temporary:// (default)"
