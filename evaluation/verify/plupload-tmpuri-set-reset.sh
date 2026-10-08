#!/usr/bin/env bash
# Execution RESET: force plupload temporary_uri back to the default so verify FAILS until the
# agent repoints it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset plupload.settings temporary_uri 'temporary://' -y >/dev/null 2>&1
echo "reset: plupload.settings temporary_uri = temporary:// (default)"
