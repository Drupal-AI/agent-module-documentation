#!/usr/bin/env bash
# RESET: field_straw_fix uses the Straw widget but the DEFAULT handler, so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_straw_fix")) {
    FieldStorageConfig::create(["field_name"=>"field_straw_fix","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!($fc = FieldConfig::loadByName("node","article","field_straw_fix"))) {
    $fc = FieldConfig::create(["field_name"=>"field_straw_fix","entity_type"=>"node","bundle"=>"article","label"=>"Fix Topics"]);
  }
  $fc->setSetting("handler","default:taxonomy_term")->setSetting("handler_settings",["target_bundles"=>["tags"=>"tags"]])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_straw_fix", ["type"=>"super_term_reference_autocomplete_widget","weight"=>62,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_straw_fix widget=straw but handler=default:taxonomy_term"
