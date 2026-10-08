#!/usr/bin/env bash
# Introspection SETUP: point plupload chunk storage at a known private URI so an inspecting
# agent can read it back from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset plupload.settings temporary_uri 'private://plupload_pl_tmp' -y >/dev/null 2>&1
echo "setup: plupload.settings temporary_uri = private://plupload_pl_tmp"
