#!/usr/bin/env bash
# Introspection SETUP: create a multi-value image field field_idf_promo on Article with the
# image_delta_formatter set to show delta 0 with the "reversed" option ON (so it shows the last
# image). Lets an agent read back the reversed setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_idf_promo")) {
    FieldStorageConfig::create(["field_name" => "field_idf_promo", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_idf_promo")) {
    FieldConfig::create(["field_name" => "field_idf_promo", "entity_type" => "node", "bundle" => "article", "label" => "Promo"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_idf_promo", [
    "type" => "image_delta_formatter", "label" => "hidden", "weight" => 41, "region" => "content",
    "settings" => ["deltas" => [0], "deltas_reversed" => TRUE, "image_style" => "", "image_link" => ""],
  ])->save();
' >/dev/null 2>&1
echo "setup: node.article field_idf_promo uses image_delta_formatter deltas=[0] reversed=TRUE"
