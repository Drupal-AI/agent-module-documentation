#!/usr/bin/env bash
# Introspection CLEANUP: nothing to restore (shipped example config is read-only baseline). No-op.
set -uo pipefail
cd /var/www/html
echo "cleanup: no changes to restore (example migrations are shipped config)"
