#!/usr/bin/env bash
# Introspection CLEANUP: uninstall workflow_ui to restore baseline (it is a hidden/obsolete or
# development-only module that is not enabled by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu workflow_ui -y >/dev/null 2>&1
echo "cleanup: workflow_ui uninstalled"
