#!/usr/bin/env bash
# Introspection CLEANUP: remove embed button vee_known. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("embed_button"); if($b=$s->load("vee_known")){$b->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: embed.button.vee_known removed"
