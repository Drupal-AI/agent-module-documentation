#!/usr/bin/env bash
# Introspection SETUP: cap the slideshow media reference field at a known number of values so
# the agent must read the live field storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("block_content", "field_slideshow_items");
  $fs->setCardinality(7)->save();
' >/dev/null 2>&1
echo "setup: field_slideshow_items cardinality=7"
