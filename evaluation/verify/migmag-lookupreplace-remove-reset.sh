#!/usr/bin/env bash
# Introspection SETUP: enable migmag_process_lookup_replace so core migration_lookup uses MigMagLookup.
set -uo pipefail
cd /var/www/html
drush en migmag_process_lookup_replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migmag_process_lookup_replace enabled (migration_lookup -> MigMagLookup)"
