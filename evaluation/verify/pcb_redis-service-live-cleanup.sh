#!/usr/bin/env bash
# Introspection CLEANUP: uninstall pcb_redis to restore baseline (leaves redis as-is). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu pcb_redis -y >/dev/null 2>&1
echo "cleanup: pcb_redis uninstalled"
