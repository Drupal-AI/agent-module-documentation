#!/usr/bin/env bash
# Execution RESET (insert_view_adv_bueditor): remove any prior answer artifact so verify FAILS on
# empty state. The submodule cannot be enabled on this D11 site (declares ^8||^9||^10) and bueditor
# cannot be installed (site's 'plugin' module fatals on route rebuild during install), so the agent
# instead LOCATES the submodule's integration facts in its real source and records them to
# /tmp/iva_bueditor_integration.txt. Idempotent. Exit 0.
set -uo pipefail
rm -f /tmp/iva_bueditor_integration.txt
echo "reset: removed /tmp/iva_bueditor_integration.txt"
