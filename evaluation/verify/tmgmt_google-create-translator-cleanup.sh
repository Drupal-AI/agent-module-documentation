#!/usr/bin/env bash
# Execution CLEANUP: delete translator tmgg_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\tmgmt\Entity\Translator; if ($t=Translator::load("tmgg_task")){$t->delete();}' >/dev/null 2>&1
echo "cleanup: tmgg_task removed"
