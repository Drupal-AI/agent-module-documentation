#!/usr/bin/env bash
# Introspection CLEANUP: uninstall ape_test to restore baseline (ships disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu ape_test -y >/dev/null 2>&1 || true
echo "cleanup: ape_test uninstalled"
