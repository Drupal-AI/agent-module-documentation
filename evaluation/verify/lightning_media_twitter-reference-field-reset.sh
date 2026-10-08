#!/usr/bin/env bash
# Execution RESET: delete the field_lm_tweet media reference field from Article so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_lm_tweet")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lm_tweet")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_lm_tweet removed from node.article"
