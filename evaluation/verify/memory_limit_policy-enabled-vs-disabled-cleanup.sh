#!/usr/bin/env bash
# Introspection CLEANUP: remove mlp_active and mlp_inactive. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("memory_limit_policy");$es=$s->loadMultiple(["mlp_active","mlp_inactive"]);if($es){$s->delete($es);}' >/dev/null 2>&1
echo "cleanup: mlp_active and mlp_inactive removed"
