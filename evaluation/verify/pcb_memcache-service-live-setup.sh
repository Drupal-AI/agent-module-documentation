#!/usr/bin/env bash
# Introspection SETUP: enable pcb_memcache (also enables memcache) so its permanent memcache
# backend service is registered. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en pcb_memcache -y >/dev/null 2>&1
echo "setup: pcb_memcache enabled (cache.backend.permanent_memcache available)"
