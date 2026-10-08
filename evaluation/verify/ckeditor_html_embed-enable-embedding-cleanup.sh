#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($e=\Drupal\editor\Entity\Editor::load("chte_hard2")){$e->delete();} if($f=\Drupal\filter\Entity\FilterFormat::load("chte_hard2")){$f->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format chte_hard2 deleted"
