#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("node"); foreach($s->loadByProperties(["title"=>"NKT Probe"]) as $n){$n->delete();}' >/dev/null 2>&1
echo "cleanup: 'NKT Probe' removed"
