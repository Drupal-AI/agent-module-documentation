#!/usr/bin/env bash
# Introspection CLEANUP: uninstall workflowfield to restore baseline (it is a hidden/obsolete or
# development-only module that is not enabled by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu workflowfield -y >/dev/null 2>&1
echo "cleanup: workflowfield uninstalled"
