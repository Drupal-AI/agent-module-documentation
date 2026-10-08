#!/usr/bin/env bash
# Execution CLEANUP: remove field_micon_pkg (and its storage). Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_micon_pkg")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_micon_pkg")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_micon_pkg removed from node.article"
