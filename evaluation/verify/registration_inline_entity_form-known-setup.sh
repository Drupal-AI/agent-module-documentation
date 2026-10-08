#!/usr/bin/env bash
# Introspection SETUP: add a registration field field_reg_ief to node.article and set its default
# form-display widget to the IEF settings widget, so an agent can read which widget is used.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_reg_ief")) {
    FieldStorageConfig::create(["field_name"=>"field_reg_ief","entity_type"=>"node","type"=>"registration"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_reg_ief")) {
    FieldConfig::create(["field_name"=>"field_reg_ief","entity_type"=>"node","bundle"=>"article","label"=>"Registration (IEF)"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_reg_ief",["type"=>"inline_entity_form_settings","weight"=>60,"region"=>"content","settings"=>["form_mode"=>"default"]])->save();
' >/dev/null 2>&1
echo "setup: node.article field_reg_ief widget=inline_entity_form_settings"
