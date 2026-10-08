#!/usr/bin/env bash
# Execution RESET: ensure NO storage type 'storage_task' exists so verify FAILS until the
# agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'try { if ($t = \Drupal\storage\Entity\StorageType::load("storage_task")) { $t->delete(); } } catch (\Throwable $e) {}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: storage type storage_task absent"
