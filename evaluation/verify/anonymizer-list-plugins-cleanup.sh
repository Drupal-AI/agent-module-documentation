#!/usr/bin/env bash
# Introspection CLEANUP: nothing was persisted; no-op. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: nothing to restore (anonymizer stores no config)"
