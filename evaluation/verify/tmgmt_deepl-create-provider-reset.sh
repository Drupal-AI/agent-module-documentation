#!/usr/bin/env bash
# Execution RESET: ensure NO tmgmt translator 'tdeepl_task' exists, so verify FAILS until the
# agent creates a DeepL Free translation provider named tdeepl_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\tmgmt\Entity\Translator; if ($t = Translator::load("tdeepl_task")) { $t->delete(); }' >/dev/null 2>&1
echo "reset: tdeepl_task translator absent"
