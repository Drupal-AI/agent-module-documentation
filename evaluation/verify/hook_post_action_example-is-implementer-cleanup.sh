#!/usr/bin/env bash
# hook_post_action_example introspection CLEANUP: no-op (kept enabled as documented baseline).
set -uo pipefail
cd /var/www/html
echo "cleanup: baseline unchanged (hook_post_action_example remains enabled)"
