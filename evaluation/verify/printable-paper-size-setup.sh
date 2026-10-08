#!/usr/bin/env bash
# Introspection SETUP: set a known PDF paper size in printable.settings.paper_size so an agent
# can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset printable.settings paper_size Letter -y >/dev/null 2>&1
echo "setup: printable.settings paper_size = Letter"
