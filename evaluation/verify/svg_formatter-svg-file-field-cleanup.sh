#!/usr/bin/env bash
# Execution CLEANUP: remove the field_svgf_build field from Article again so the site returns
# to baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_svgf_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_svgf_build")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_svgf_build removed from node.article"
