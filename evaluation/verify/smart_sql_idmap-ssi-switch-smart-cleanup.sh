#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("migration"); if($e=$s->load("ssi_switch")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: ssi_switch removed"
