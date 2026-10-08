#!/usr/bin/env bash
# Introspection CLEANUP: remove field_tr_which and field_tr_other from node.article.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["field_tr_which","field_tr_other"] as $fn) {
    if ($fc=\Drupal\field\Entity\FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs=\Drupal\field\Entity\FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tr_which and field_tr_other removed from node.article"
