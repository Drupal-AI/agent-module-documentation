#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$p=\Drupal::entityTypeManager()->getStorage("pagerer_preset")->load("pgr_task"); if($p){$p->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pagerer_preset 'pgr_task' removed"
