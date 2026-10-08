#!/usr/bin/env bash
# Introspection SETUP: set Trim's module weight to a known sentinel (1234) in core.extension
# so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("trim", 1234);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: trim module weight set to 1234"
