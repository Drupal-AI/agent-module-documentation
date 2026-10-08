#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if($b=Block::load("pwa_a2hs_named")){$b->delete();}' >/dev/null 2>&1
echo "cleanup: block pwa_a2hs_named removed"
