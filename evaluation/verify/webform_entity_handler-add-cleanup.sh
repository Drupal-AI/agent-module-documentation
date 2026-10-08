#!/usr/bin/env bash
# Execution CLEANUP: delete webform weh_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\webform\Entity\Webform; if ($w = Webform::load("weh_task")) { $w->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform weh_task removed"
