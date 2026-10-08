#!/usr/bin/env bash
# hook_post_action introspection CLEANUP: no-op (hook_post_action_example is left enabled as the
# documented baseline for this module). Idempotent.
set -uo pipefail
cd /var/www/html
echo "cleanup: baseline unchanged (hook_post_action_example remains enabled)"
