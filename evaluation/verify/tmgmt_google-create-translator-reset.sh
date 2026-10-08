#!/usr/bin/env bash
# Execution RESET: ensure translator tmgg_task does NOT exist so verify FAILS until created. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\tmgmt\Entity\Translator; if ($t=Translator::load("tmgg_task")){$t->delete();}' >/dev/null 2>&1
echo "reset: tmgg_task removed"
