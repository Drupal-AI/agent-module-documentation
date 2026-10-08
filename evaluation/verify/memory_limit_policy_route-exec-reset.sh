#!/usr/bin/env bash
# Execution RESET for memory_limit_policy_route: ensure mlp_route_exec is absent (verify FAILs on empty state).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_route_exec")){$e->delete();}' >/dev/null 2>&1
echo "reset: mlp_route_exec absent"
