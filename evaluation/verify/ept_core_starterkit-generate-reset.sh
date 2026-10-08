#!/usr/bin/env bash
# Execution RESET: remove any previously generated ept_test_hero module dir so verify FAILS on
# empty state. Does NOT enable anything. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/ept_test_hero
echo "reset: web/modules/custom/ept_test_hero removed"
