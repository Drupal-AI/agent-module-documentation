#!/usr/bin/env bash
# Introspection SETUP: create datetime field field_da_known on Article and store date_augmenter
# third-party settings (instances.status.add_to_calendar = true) on its formatter component in the
# default VIEW display, so an agent can read back which field has augmenters configured. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_da_known")) {
    FieldStorageConfig::create(["field_name"=>"field_da_known","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_da_known")) {
    FieldConfig::create(["field_name"=>"field_da_known","entity_type"=>"node","bundle"=>"article","label"=>"DA Known Date"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_da_known", [
    "type"=>"datetime_default","label"=>"above","weight"=>50,"region"=>"content",
    "third_party_settings"=>["date_augmenter"=>["instances"=>["status"=>["add_to_calendar"=>true],"weights"=>["order"=>["add_to_calendar"=>["weight"=>0]]]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_da_known has date_augmenter third-party settings"
