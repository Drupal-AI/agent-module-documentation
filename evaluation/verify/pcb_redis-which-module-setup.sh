#!/usr/bin/env bash
# Introspection SETUP: enable pcb_redis so its permanent redis backend service is registered.
# (redis contrib module is already enabled at baseline.) Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en pcb_redis -y >/dev/null 2>&1
echo "setup: pcb_redis enabled (cache.backend.permanent_redis available)"
