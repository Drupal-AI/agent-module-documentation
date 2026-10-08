#!/usr/bin/env bash
# Execution CLEANUP: delete the field_lm_ig_post field from Article.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_lm_ig_post")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lm_ig_post")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_lm_ig_post removed from node.article"
