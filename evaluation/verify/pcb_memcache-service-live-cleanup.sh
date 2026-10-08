#!/usr/bin/env bash
# Introspection CLEANUP: uninstall pcb_memcache AND its memcache dependency to restore baseline
# (both were disabled at baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu pcb_memcache -y >/dev/null 2>&1 || true
drush pmu memcache -y >/dev/null 2>&1 || true
echo "cleanup: pcb_memcache and memcache uninstalled"
