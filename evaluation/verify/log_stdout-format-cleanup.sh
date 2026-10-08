#!/usr/bin/env bash
# Introspection CLEANUP: restore Log Stdout shipped default format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings format '[@severity] [@type] [@date] @message | uid: @uid | request-uri: @request_uri | refer: @referer | ip:  @ip | link: @link' >/dev/null 2>&1
echo "cleanup: log_stdout.settings format restored to shipped default"
