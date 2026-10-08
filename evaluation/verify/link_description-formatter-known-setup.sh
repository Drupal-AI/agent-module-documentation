#!/usr/bin/env bash
# Introspection SETUP: create a link_description field field_ld_disp2 on Article and set its default
# view display to the link_separate_description formatter, so an agent can read back the formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ld_disp2")) {
    FieldStorageConfig::create(["field_name" => "field_ld_disp2", "entity_type" => "node", "type" => "link_description", "cardinality" => 1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ld_disp2")) {
    FieldConfig::create(["field_name" => "field_ld_disp2", "entity_type" => "node", "bundle" => "article", "label" => "Known Display LD", "settings" => ["title" => 1, "link_type" => 0x11]])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_ld_disp2", ["type" => "link_separate_description", "label" => "above", "weight" => 61, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
echo "setup: field_ld_disp2 uses link_separate_description formatter on node.article.default"
