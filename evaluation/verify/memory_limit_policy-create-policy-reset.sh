#!/usr/bin/env bash
# Execution RESET: ensure policy mlp_exec_policy does NOT exist (so verify FAILs on empty
# state). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_exec_policy")){$e->delete();}' >/dev/null 2>&1
echo "reset: mlp_exec_policy absent"
