#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\webform\Entity\Webform; if ($w = Webform::load("wmc_known")) { $w->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform wmc_known removed"
