#!/usr/bin/env bash
# Introspection CLEANUP: delete sa_users_probe. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("autocompletion_configuration"); if($e=$s->load("sa_users_probe")) $e->delete();' >/dev/null 2>&1
echo "cleanup: sa_users_probe removed"
