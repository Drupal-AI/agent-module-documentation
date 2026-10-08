#!/usr/bin/env bash
# Introspection CLEANUP: restore ide to the shipped default (phpstorm). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings ide 'phpstorm://open?file=%f&line=%l' >/dev/null 2>&1
echo "cleanup: webprofiler.settings ide restored to phpstorm default"
