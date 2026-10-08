#!/usr/bin/env bash
# Execution CLEANUP: remove field_pdf_manual from Article, dropping its view-display
# component. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_pdf_manual")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_pdf_manual")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pdf_manual removed from node.article"
