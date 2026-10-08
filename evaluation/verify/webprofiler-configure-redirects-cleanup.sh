#!/usr/bin/env bash
# Execution CLEANUP: restore both keys to shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings intercept_redirects 0 >/dev/null 2>&1
drush cset -y webprofiler.settings purge_on_cache_clear 1 >/dev/null 2>&1
echo "cleanup: webprofiler redirect/purge settings restored to defaults"
