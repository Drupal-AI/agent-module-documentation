#!/usr/bin/env bash
# Execution RESET: clear the target dir so no breakpoint template exists yet (verify FAILS
# on this empty state). Idempotent. Exit 0.
set -uo pipefail
D=/var/www/html/web/sites/default/files/tx_hard1
rm -rf "$D"
mkdir -p "$D"
echo "reset: cleared $D (no template present)"
