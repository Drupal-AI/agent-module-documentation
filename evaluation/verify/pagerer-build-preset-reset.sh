#!/usr/bin/env bash
# Execution RESET: ensure no pagerer_preset 'pgr_task' exists, so verify FAILS until the agent
# creates it with a progressive-style center pane. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$p=\Drupal::entityTypeManager()->getStorage("pagerer_preset")->load("pgr_task"); if($p){$p->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pagerer_preset 'pgr_task' absent"
