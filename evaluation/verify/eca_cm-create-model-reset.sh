#!/usr/bin/env bash
# Execution RESET: ensure model 'eca_cm_task' does NOT exist (so verify FAILS until created). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("eca")->load("eca_cm_task"); if($e){$e->delete();}' >/dev/null 2>&1
echo "reset: eca_cm_task absent"
