#!/usr/bin/env bash
# Introspection CLEANUP: no-op. Baseline for this campaign leaves the module enabled (installs
# are cumulative), and the example's template/fields are owned by message_example, not created
# by the eval. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: none required (module left enabled per campaign baseline)"
