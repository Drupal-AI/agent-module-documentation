#!/usr/bin/env bash
# Execution CLEANUP: remove field_tr_shift from node.article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc=\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tr_shift")) { $fc->delete(); }
  if ($fs=\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_tr_shift")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tr_shift removed from node.article"
