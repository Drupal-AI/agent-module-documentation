#!/usr/bin/env bash
# Introspection CLEANUP: restore better_search.settings defaults. Exit 0.
set -uo pipefail
cd /var/www/html
exec bash agent-module-documentation/evaluation/verify/better_search-restore.sh
