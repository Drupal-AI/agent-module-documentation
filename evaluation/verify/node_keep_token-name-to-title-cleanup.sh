#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("node"); foreach($s->loadByProperties(["title"=>"NKT Home Page"]) as $n){$n->delete();}' >/dev/null 2>&1
echo "cleanup: 'NKT Home Page' removed"
