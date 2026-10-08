#!/usr/bin/env bash
# Execution RESET: ensure link field field_btl_task2 exists on Article with core 'link'
# formatter on the default view display so verify FAILS until the agent configures button_link.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_btl_task2")) {
    FieldStorageConfig::create(["field_name" => "field_btl_task2", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_btl_task2")) {
    FieldConfig::create(["field_name" => "field_btl_task2", "entity_type" => "node", "bundle" => "article", "label" => "Task CTA 2"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_btl_task2", ["type" => "link", "label" => "hidden", "weight" => 53, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_btl_task2 present with core 'link' formatter"
