#!/usr/bin/env bash
# Introspection SETUP: set a distinctive Log Stdout line format so an agent can read
# it back from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings format 'LOGSTDOUT-TEST [@severity] @type: @message' >/dev/null 2>&1
echo "setup: log_stdout.settings format = LOGSTDOUT-TEST [@severity] @type: @message"
