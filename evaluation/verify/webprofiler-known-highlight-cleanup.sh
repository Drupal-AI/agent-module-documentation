#!/usr/bin/env bash
# Introspection CLEANUP: restore query_highlight to shipped default (5).
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings query_highlight 5 >/dev/null 2>&1
echo "cleanup: webprofiler.settings query_highlight restored to 5"
