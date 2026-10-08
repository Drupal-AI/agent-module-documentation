#!/usr/bin/env bash
# Execution RESET: ensure pcb_memcache (and memcache) are UNINSTALLED so the permanent memcache
# service is absent and verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu pcb_memcache -y >/dev/null 2>&1 || true
drush pmu memcache -y >/dev/null 2>&1 || true
echo "reset: pcb_memcache/memcache uninstalled (service absent)"
