#!/usr/bin/env bash
# Introspection CLEANUP: delete ECA model ectamp_tok. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("eca"); if($e=$s->load("ectamp_tok")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eca model ectamp_tok removed"
