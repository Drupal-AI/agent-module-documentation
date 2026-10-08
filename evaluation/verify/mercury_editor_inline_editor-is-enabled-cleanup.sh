#!/usr/bin/env bash
# Introspection CLEANUP: uninstall the module to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu mercury_editor_inline_editor -y >/dev/null 2>&1
echo "cleanup: mercury_editor_inline_editor uninstalled"
