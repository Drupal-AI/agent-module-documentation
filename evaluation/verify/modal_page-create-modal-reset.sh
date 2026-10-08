#!/usr/bin/env bash
# Execution RESET (modal_page H1): delete the modal 'mp_task' so the agent must create it.
# Empty state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\modal_page\Entity\Modal; if ($m=Modal::load("mp_task")){$m->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: modal mp_task removed"
