#!/usr/bin/env bash
# Execution CLEANUP: delete reaction rule rer_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("rules_reaction_rule"); if($e=$s->load("rer_task")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: rer_task removed"
