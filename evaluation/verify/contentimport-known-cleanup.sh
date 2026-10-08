#!/usr/bin/env bash
# Introspection CLEANUP (contentimport): no site state was changed by setup; nothing to restore.
# Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: contentimport introspection made no changes (nothing to restore)"
