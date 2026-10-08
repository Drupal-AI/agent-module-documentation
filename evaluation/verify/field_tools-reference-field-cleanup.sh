#!/usr/bin/env bash
# Introspection CLEANUP: delete field_ft_ref storage (removes its instance). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fs = FieldStorageConfig::loadByName("node", "field_ft_ref")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ft_ref removed"
