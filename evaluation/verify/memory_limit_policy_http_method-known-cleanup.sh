#!/usr/bin/env bash
# Introspection CLEANUP for memory_limit_policy_http_method: remove mlp_http_method_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_http_method_known")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: mlp_http_method_known removed"
