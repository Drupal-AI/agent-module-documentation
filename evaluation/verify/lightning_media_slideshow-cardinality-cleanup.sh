#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped unlimited cardinality (-1).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("block_content", "field_slideshow_items");
  $fs->setCardinality(-1)->save();
' >/dev/null 2>&1
echo "cleanup: field_slideshow_items cardinality restored to unlimited"
