#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\webform\Entity\Webform; if ($w=Webform::load("dtf_wf_task")) { $w->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dtf_wf_task removed"
