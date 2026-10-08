#!/usr/bin/env bash
# Introspection CLEANUP: remove field_pdf_cover and field_pdf_scroll from Article, dropping
# both entity_view_display components. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_pdf_cover", "field_pdf_scroll"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pdf_cover and field_pdf_scroll removed from node.article"
