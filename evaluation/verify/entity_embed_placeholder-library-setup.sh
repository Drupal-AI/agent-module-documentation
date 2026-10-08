#!/usr/bin/env bash
# Introspection SETUP: no planted config needed — the entity_embed_placeholder/common library is
# attached to entity_embed's library at runtime by hook_library_info_alter. Rebuild caches so the
# live library discovery reflects enabled modules, then the agent must inspect it. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: caches rebuilt; inspect the entity_embed/entity_embed library dependencies"
