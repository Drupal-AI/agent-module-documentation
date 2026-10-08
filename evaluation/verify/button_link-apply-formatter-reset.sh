#!/usr/bin/env bash
# Execution RESET: ensure link field field_btl_task exists on Article and force its default
# view-display formatter to core 'link' (NOT button_link) so verify FAILS until the agent
# switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_btl_task")) {
    FieldStorageConfig::create(["field_name" => "field_btl_task", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_btl_task")) {
    FieldConfig::create(["field_name" => "field_btl_task", "entity_type" => "node", "bundle" => "article", "label" => "Task CTA"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_btl_task", ["type" => "link", "label" => "hidden", "weight" => 52, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_btl_task present with core 'link' formatter"
