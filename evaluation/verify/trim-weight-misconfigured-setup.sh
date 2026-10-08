#!/usr/bin/env bash
# Introspection SETUP: deliberately mis-set Trim's module weight to -5 (too low to validate
# first) so an agent can read the live core.extension value and diagnose it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("trim", -5);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: trim module weight set to -5 (misconfigured)"
