#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($f=\Drupal\filter\Entity\FilterFormat::load("toc_filter_hard2")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format toc_filter_hard2 deleted"
