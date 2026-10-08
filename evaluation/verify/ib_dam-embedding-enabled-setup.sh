#!/usr/bin/env bash
# Introspection SETUP: enable asset embedding.
set -uo pipefail
cd /var/www/html
drush cset ib_dam.settings allow_embedding 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ib_dam.settings.allow_embedding=true"
