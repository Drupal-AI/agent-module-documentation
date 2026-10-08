#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if($b=Block::load("htm_task")){$b->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block htm_task removed"
