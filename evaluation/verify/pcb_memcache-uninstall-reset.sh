#!/usr/bin/env bash
# Execution RESET: ensure pcb_memcache is INSTALLED (also enables memcache) so the permanent
# memcache service is present and verify FAILS until the agent uninstalls it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en pcb_memcache -y >/dev/null 2>&1
echo "reset: pcb_memcache installed (service present)"
