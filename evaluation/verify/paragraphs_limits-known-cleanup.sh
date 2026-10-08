#!/usr/bin/env bash
# Introspection CLEANUP: remove field_pl_para and paragraph type pl_text.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\ParagraphsType;
  if ($fc = FieldConfig::loadByName("node","article","field_pl_para")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_pl_para")) { $fs->delete(); }
  if ($pt = ParagraphsType::load("pl_text")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pl_para and pl_text removed"
