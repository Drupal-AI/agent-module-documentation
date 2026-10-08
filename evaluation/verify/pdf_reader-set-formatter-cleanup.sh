#!/usr/bin/env bash
# Execution CLEANUP (pdf_reader): remove field_pdf_task. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_pdf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_pdf_task")) { $fs->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: field_pdf_task removed"
exit 0
