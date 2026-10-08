#!/usr/bin/env bash
# Execution RESET: ensure a link_description field field_ld_disp exists on Article and its default
# view display uses the compact 'link_description' formatter (NOT link_separate_description), so
# verify FAILS until the agent switches the formatter. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ld_disp")) {
    FieldStorageConfig::create(["field_name" => "field_ld_disp", "entity_type" => "node", "type" => "link_description", "cardinality" => 1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ld_disp")) {
    FieldConfig::create(["field_name" => "field_ld_disp", "entity_type" => "node", "bundle" => "article", "label" => "Display LD", "settings" => ["title" => 1, "link_type" => 0x11]])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ld_disp", ["type" => "link_description", "label" => "above", "weight" => 60, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
echo "reset: field_ld_disp uses link_description formatter on node.article.default"
