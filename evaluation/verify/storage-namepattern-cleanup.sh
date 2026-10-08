#!/usr/bin/env bash
# Introspection CLEANUP: delete the storage_known storage type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'try { if ($t = \Drupal\storage\Entity\StorageType::load("storage_known")) { $t->delete(); } } catch (\Throwable $e) {}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: storage type storage_known removed"
