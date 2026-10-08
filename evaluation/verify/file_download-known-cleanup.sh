#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fd_known (drops its display component too). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_fd_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_fd_known")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_fd_known removed"
