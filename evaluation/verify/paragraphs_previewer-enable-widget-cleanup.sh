#!/usr/bin/env bash
# Execution CLEANUP: remove field_pp_task and paragraph type pp_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_pp_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_pp_task")) { $fs->delete(); }
  if ($pt = ParagraphsType::load("pp_task")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_pp_task and paragraph type pp_task removed"
