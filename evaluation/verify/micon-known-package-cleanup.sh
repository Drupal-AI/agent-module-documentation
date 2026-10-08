#!/usr/bin/env bash
# Introspection CLEANUP: remove field_micon_known (drops its form-display component too).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_micon_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_micon_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_micon_known removed from node.article"
