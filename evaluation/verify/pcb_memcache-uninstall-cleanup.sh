#!/usr/bin/env bash
# Execution CLEANUP: ensure pcb_memcache and memcache uninstalled (baseline). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu pcb_memcache -y >/dev/null 2>&1 || true
drush pmu memcache -y >/dev/null 2>&1 || true
echo "cleanup: pcb_memcache and memcache uninstalled"
