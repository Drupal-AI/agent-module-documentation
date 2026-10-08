#!/usr/bin/env bash
# Execution RESET: remove any generated potx template files from the Drupal docroot so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
ROOT=$(drush php:eval 'echo DRUPAL_ROOT;' 2>/dev/null)
[ -n "$ROOT" ] || ROOT=/var/www/html/web
rm -f "$ROOT/general.pot" "$ROOT/installer.pot"
echo "reset: removed general.pot/installer.pot from $ROOT"
