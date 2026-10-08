#!/usr/bin/env bash
# Introspection SETUP: create a link field field_fr_go on Article whose field_redirection
# formatter has the "404 if URL empty" option ON (code 301), so an agent can read that back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fr_go")) {
    FieldStorageConfig::create(["field_name" => "field_fr_go", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fr_go")) {
    FieldConfig::create(["field_name" => "field_fr_go", "entity_type" => "node", "bundle" => "article", "label" => "Go To"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fr_go", [
    "type" => "field_redirection_formatter", "label" => "hidden", "weight" => 45, "region" => "content",
    "settings" => ["code" => 301, "404_if_empty" => TRUE, "page_restrictions" => 0, "pages" => ""],
  ])->save();
' >/dev/null 2>&1
echo "setup: node.article field_fr_go uses field_redirection_formatter 404_if_empty=TRUE"
