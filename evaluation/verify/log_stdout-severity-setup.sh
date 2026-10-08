#!/usr/bin/env bash
# Introspection SETUP: set a known Log Stdout config (severity_level=7 "Debug",
# use_stderr off) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y log_stdout.settings severity_level 7 >/dev/null 2>&1
drush cset -y log_stdout.settings use_stderr 0 >/dev/null 2>&1
echo "setup: log_stdout.settings severity_level=7 use_stderr=0"
