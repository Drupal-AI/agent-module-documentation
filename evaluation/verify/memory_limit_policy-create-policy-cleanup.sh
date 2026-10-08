#!/usr/bin/env bash
# Execution CLEANUP: remove mlp_exec_policy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_exec_policy")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: mlp_exec_policy removed"
