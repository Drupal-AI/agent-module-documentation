#!/usr/bin/env bash
# Introspection CLEANUP: remove the disabled um_fixture fixture directory. Safe (never enabled, so
# no uninstall needed). Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/um_fixture
echo "cleanup: web/modules/custom/um_fixture removed"
