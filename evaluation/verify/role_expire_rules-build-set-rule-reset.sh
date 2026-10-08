#!/usr/bin/env bash
# Execution RESET: delete any reaction rule rer_task so verify FAILS until the agent builds it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("rules_reaction_rule"); if($e=$s->load("rer_task")){$e->delete();}' >/dev/null 2>&1
echo "reset: rer_task removed"
