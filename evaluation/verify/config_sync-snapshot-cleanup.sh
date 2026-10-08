#!/usr/bin/env bash
# Introspection CLEANUP: no-op restore. The external_link_popup snapshot is normal baseline
# config_sync data (created at install), so it is left in place. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: config_sync snapshot for external_link_popup left as baseline"
