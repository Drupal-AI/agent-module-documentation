#!/usr/bin/env bash
# Execution CLEANUP: remove field_miu_desc + its form-display component. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("menu_link_content", "menu_link_content", "field_miu_desc")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("menu_link_content", "field_miu_desc")) { $fs->delete(); }
  if ($fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("menu_link_content.menu_link_content.default")) {
    if ($fd->getComponent("field_miu_desc")) { $fd->removeComponent("field_miu_desc")->save(); }
  }
' >/dev/null 2>&1
echo "cleanup: field_miu_desc removed"
