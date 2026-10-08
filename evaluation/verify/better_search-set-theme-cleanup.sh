#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
exec bash agent-module-documentation/evaluation/verify/better_search-restore.sh
