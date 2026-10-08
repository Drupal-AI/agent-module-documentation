#!/usr/bin/env bash
# Introspection SETUP (tzfield): create a Time zone field field_tz_known on Article using the
# tzfield_offset widget, with default_site on and Antarctica/Troll excluded. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tz_known")) {
    FieldStorageConfig::create(["field_name"=>"field_tz_known","entity_type"=>"node","type"=>"tzfield"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tz_known")) {
    FieldConfig::create([
      "field_name"=>"field_tz_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Time Zone",
      "settings"=>["exclude"=>["Antarctica/Troll"],"default_site"=>TRUE,"default_user"=>FALSE],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_tz_known",["type"=>"tzfield_offset","region"=>"content","weight"=>40])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_tz_known (tzfield) widget=tzfield_offset default_site=true exclude=Antarctica/Troll"
