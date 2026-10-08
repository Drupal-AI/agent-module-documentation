#!/usr/bin/env bash
# Execution CLEANUP: remove the generated ept_test_hero module dir (it is never enabled, so no
# pmu needed). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/ept_test_hero
echo "cleanup: web/modules/custom/ept_test_hero removed"
