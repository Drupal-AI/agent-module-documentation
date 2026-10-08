#!/usr/bin/env bash
# Introspection CLEANUP: no persistent state to restore for this parser introspection. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: nothing to restore (parser introspection is read-only)"
