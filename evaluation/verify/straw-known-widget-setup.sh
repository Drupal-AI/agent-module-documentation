#!/usr/bin/env bash
# Introspection SETUP: create a term-reference field field_straw_known on Article, set its
# handler to 'straw' and its form widget to the Straw widget, so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_straw_known")) {
    FieldStorageConfig::create(["field_name"=>"field_straw_known","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!($fc = FieldConfig::loadByName("node","article","field_straw_known"))) {
    $fc = FieldConfig::create(["field_name"=>"field_straw_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Topics","settings"=>["handler"=>"straw","handler_settings"=>["target_bundles"=>["tags"=>"tags"]]]]);
    $fc->save();
  } else {
    $fc->setSetting("handler","straw")->setSetting("handler_settings",["target_bundles"=>["tags"=>"tags"]])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_straw_known", ["type"=>"super_term_reference_autocomplete_widget","weight"=>60,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_straw_known uses handler=straw widget=super_term_reference_autocomplete_widget"
