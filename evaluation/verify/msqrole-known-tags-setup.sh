#!/usr/bin/env bash
# Introspection SETUP: set msqrole.settings tags_to_invalidate to a known cache tag so an agent
# can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset msqrole.settings tags_to_invalidate 'config:block.block.olivero_account_menu' -y >/dev/null 2>&1
echo "setup: msqrole.settings tags_to_invalidate=config:block.block.olivero_account_menu"
