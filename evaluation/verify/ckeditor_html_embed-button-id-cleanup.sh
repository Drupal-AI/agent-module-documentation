#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($e=\Drupal\editor\Entity\Editor::load("chte_med2")){$e->delete();} if($f=\Drupal\filter\Entity\FilterFormat::load("chte_med2")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format chte_med2 deleted"
