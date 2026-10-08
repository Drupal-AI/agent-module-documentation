#!/usr/bin/env bash
# Execution RESET: ensure policy mlp_ai_exec is absent (verify FAILs on empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");if($e=$s->load("mlp_ai_exec")){$e->delete();}' >/dev/null 2>&1
echo "reset: mlp_ai_exec absent"
