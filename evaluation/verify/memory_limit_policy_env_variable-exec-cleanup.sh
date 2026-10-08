#!/usr/bin/env bash
# Execution CLEANUP for memory_limit_policy_env_variable: remove mlp_env_variable_exec. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_env_variable_exec")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: mlp_env_variable_exec removed"
