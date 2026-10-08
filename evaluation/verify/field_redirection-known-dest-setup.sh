#!/usr/bin/env bash
# Introspection SETUP: create a link field field_fr_dest on Article and configure its default
# view-display formatter to field_redirection_formatter with HTTP code 302 and a page
# restriction, so an agent can read back the configured status code. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fr_dest")) {
    FieldStorageConfig::create(["field_name" => "field_fr_dest", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fr_dest")) {
    FieldConfig::create(["field_name" => "field_fr_dest", "entity_type" => "node", "bundle" => "article", "label" => "Destination"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fr_dest", [
    "type" => "field_redirection_formatter", "label" => "hidden", "weight" => 44, "region" => "content",
    "settings" => ["code" => 302, "404_if_empty" => FALSE, "page_restrictions" => 1, "pages" => "admin/*"],
  ])->save();
' >/dev/null 2>&1
echo "setup: node.article field_fr_dest uses field_redirection_formatter code=302"
