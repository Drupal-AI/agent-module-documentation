#!/usr/bin/env bash
# Introspection CLEANUP for memory_limit_policy_env_variable: remove mlp_env_variable_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_env_variable_known")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: mlp_env_variable_known removed"
