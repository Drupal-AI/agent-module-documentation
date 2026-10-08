#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($t = \Drupal\simple_megamenu\Entity\SimpleMegaMenuType::load("smm_task")) { $t->delete(); }' >/dev/null 2>&1
echo "cleanup: smm_task removed"
