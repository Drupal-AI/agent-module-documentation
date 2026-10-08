#!/usr/bin/env bash
# Introspection CLEANUP (check_dns): baseline is check_dns ENABLED (it ships enabled
# for this campaign), so nothing to tear down. Left enabled on purpose. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: check_dns left enabled (baseline)"
