#!/usr/bin/env bash
# Execution RESET: force the two target keys to shipped defaults (intercept_redirects=false,
# purge_on_cache_clear=true) so verify FAILS until the agent changes them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings intercept_redirects 0 >/dev/null 2>&1
drush cset -y webprofiler.settings purge_on_cache_clear 1 >/dev/null 2>&1
echo "reset: intercept_redirects=false, purge_on_cache_clear=true"
