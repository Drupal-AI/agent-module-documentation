#!/usr/bin/env bash
# Introspection CLEANUP: remove field_pdf_report from Article, which also drops its
# entity_view_display component and the pdf_default formatter settings. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_pdf_report")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_pdf_report")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pdf_report removed from node.article"
