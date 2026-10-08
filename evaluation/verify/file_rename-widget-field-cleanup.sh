#!/usr/bin/env bash
# Introspection CLEANUP: remove field_fr_doc from Article (drops its form-display component and
# the file_rename third-party setting) and restore the global flag to its default (1).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fr_doc")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fr_doc")) { $fs->delete(); }
' >/dev/null 2>&1
drush config:set file_rename.settings always_show_widget_link 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fr_doc removed; always_show_widget_link restored to 1"
