#!/usr/bin/env bash
# Introspection SETUP: create a core link field field_li_known on Article and display it with
# the linkicon formatter using prefix 'fa', so an agent can discover which field uses Link Icon.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_li_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_li_known", "entity_type" => "node",
      "type" => "link", "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_li_known")) {
    FieldConfig::create([
      "field_name" => "field_li_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Social Links",
    ])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_li_known", [
    "type" => "linkicon", "label" => "hidden", "weight" => 60, "region" => "content",
    "settings" => ["linkicon_prefix" => "fa"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_li_known displayed with linkicon formatter (prefix fa)"
