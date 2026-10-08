#!/usr/bin/env bash
# Introspection SETUP: enable the media_gallery_migration2 submodule so its three migrate_plus migration config
# entities (group media_gallery) are registered on the live site for the agent to inspect.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en media_gallery_migration2 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_gallery_migration2 enabled (migrations registered)"
