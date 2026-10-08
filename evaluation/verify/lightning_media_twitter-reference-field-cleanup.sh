#!/usr/bin/env bash
# Execution CLEANUP: delete the field_lm_tweet field from Article.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_lm_tweet")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lm_tweet")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_lm_tweet removed from node.article"
