#!/usr/bin/env bash
# Execution CLEANUP: delete the ti_task vocabulary (removes its terms). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; if ($v = Vocabulary::load("ti_task")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: vocabulary ti_task removed"
