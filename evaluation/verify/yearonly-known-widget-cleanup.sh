#!/usr/bin/env bash
# Introspection CLEANUP: remove the known node.article field_year_widget yearonly field
# (form display component + config + storage), restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  if ($fd->getComponent("field_year_widget")) { $fd->removeComponent("field_year_widget")->save(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_year_widget")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_year_widget")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_year_widget removed"
