#!/usr/bin/env bash
# Introspection SETUP: ensure migmag_process is enabled (baseline) so its process plugins and the
# migmag_process.lookup.stub service are discoverable. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_process || drush en migmag_process -y >/dev/null 2>&1
echo "setup: migmag_process enabled"
