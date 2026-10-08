#!/usr/bin/env bash
# Introspection CLEANUP for memory_limit_policy_role: remove mlp_role_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_role_known")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: mlp_role_known removed"
