#!/usr/bin/env bash
# Introspection CLEANUP: remove field_tr_known from node.article (drops the form-display
# component too). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc=\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tr_known")) { $fc->delete(); }
  if ($fs=\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_tr_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tr_known removed from node.article"
