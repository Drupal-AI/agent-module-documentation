#!/usr/bin/env bash
# Introspection SETUP: create a text_long field field_tfc_known on Article using the
# text_textarea_with_counter widget with a known maxlength (140), so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_tfc_known")) {
    FieldStorageConfig::create(["field_name"=>"field_tfc_known","entity_type"=>"node","type"=>"text_long"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_tfc_known")) {
    FieldConfig::create(["field_name"=>"field_tfc_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Counted Body"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_tfc_known", ["type"=>"text_textarea_with_counter","weight"=>60,"region"=>"content","settings"=>["maxlength"=>140,"counter_position"=>"after"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tfc_known uses text_textarea_with_counter maxlength=140"
