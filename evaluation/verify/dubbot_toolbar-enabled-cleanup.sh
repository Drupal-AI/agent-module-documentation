#!/usr/bin/env bash
# Introspection CLEANUP: uninstall dubbot_toolbar to restore the shipped baseline (submodule
# off by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu dubbot_toolbar -y >/dev/null 2>&1
echo "cleanup: dubbot_toolbar uninstalled"
