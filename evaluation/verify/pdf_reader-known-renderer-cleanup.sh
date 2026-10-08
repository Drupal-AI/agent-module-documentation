#!/usr/bin/env bash
# Introspection CLEANUP (pdf_reader): remove field_pdf_render. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_pdf_render")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_pdf_render")) { $fs->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: field_pdf_render removed"
exit 0
