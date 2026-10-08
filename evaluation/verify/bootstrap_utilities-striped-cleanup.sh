#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if($f=FilterFormat::load("buty_tbl")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format buty_tbl removed"
