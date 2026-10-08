#!/usr/bin/env bash
# Introspection SETUP: add a link field field_ftlf_link to Article and set its default view
# display to the fixed_text_link formatter with a known link_text, so an agent can read the
# configured fixed text back from display config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ftlf_link")) {
    FieldStorageConfig::create(["field_name"=>"field_ftlf_link","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ftlf_link")) {
    FieldConfig::create(["field_name"=>"field_ftlf_link","entity_type"=>"node","bundle"=>"article","label"=>"FTLF Link"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ftlf_link", [
    "type"=>"fixed_text_link","label"=>"hidden","weight"=>50,"region"=>"content",
    "settings"=>["link_text"=>"Visit Our Partner","link_class"=>"","allow_override"=>FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ftlf_link uses fixed_text_link, link_text=Visit Our Partner"
