#!/usr/bin/env bash
# Introspection SETUP: display a string field via wrapper_class wrapped in an h2 with a class.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecf_txt")) { FieldStorageConfig::create(["field_name"=>"field_ecf_txt","entity_type"=>"node","type"=>"string"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecf_txt")) { FieldConfig::create(["field_name"=>"field_ecf_txt","entity_type"=>"node","bundle"=>"article","label"=>"ECF Text"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecf_txt", ["type"=>"wrapper_class","label"=>"hidden","weight"=>51,"region"=>"content","settings"=>["class"=>"lead","tag"=>"h2","link"=>0,"link_class"=>"","summary"=>false,"trim"=>200]])->save();
' >/dev/null 2>&1
echo "setup: field_ecf_txt uses wrapper_class tag=h2 class=lead"
