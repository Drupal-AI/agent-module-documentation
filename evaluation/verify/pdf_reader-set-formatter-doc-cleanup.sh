#!/usr/bin/env bash
# Execution CLEANUP (pdf_reader, layman): remove field_pdf_doc. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_pdf_doc")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_pdf_doc")) { $fs->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: field_pdf_doc removed"
exit 0
