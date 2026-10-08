#!/usr/bin/env bash
# Introspection CLEANUP: nothing to restore (no state written; module is left enabled as it is a
# baseline dependency of the docs). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: nothing to restore"
