#!/usr/bin/env bash
# Introspection CLEANUP: restore path_file.settings allowed_extensions to the shipped default.
set -uo pipefail
cd /var/www/html
drush cset path_file.settings allowed_extensions 'pdf jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: path_file.settings allowed_extensions restored to default"
