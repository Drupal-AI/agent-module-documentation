#!/usr/bin/env bash
# Execution RESET: ensure field_miu_desc + its form-display component ABSENT so verify FAILS.
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
echo "reset: field_miu_desc absent from menu_link_content + default form display"
