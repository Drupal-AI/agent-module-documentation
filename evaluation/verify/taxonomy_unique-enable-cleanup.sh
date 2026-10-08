#!/usr/bin/env bash
# Execution CLEANUP: delete vocabulary tu_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; if($v=Vocabulary::load("tu_task")){$v->delete();}' >/dev/null 2>&1
echo "cleanup: vocabulary tu_task removed"
