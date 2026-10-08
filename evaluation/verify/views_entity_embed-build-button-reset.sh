#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete embed button vee_btn so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("embed_button"); if($b=$s->load("vee_btn")){$b->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: embed.button.vee_btn absent"
