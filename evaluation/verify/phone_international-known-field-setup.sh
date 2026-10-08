#!/usr/bin/env bash
# Introspection SETUP: create a phone_international field field_pi_known on Article whose widget
# default (initial) country is GB, so an agent can read the widget setting from the form
# display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pi_known")) {
    FieldStorageConfig::create(["field_name"=>"field_pi_known","entity_type"=>"node","type"=>"phone_international"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pi_known")) {
    FieldConfig::create(["field_name"=>"field_pi_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Phone"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pi_known", [
    "type" => "phone_international_widget", "weight" => 50, "region" => "content",
    "settings" => ["initial_country"=>"GB","geolocation"=>FALSE,"countries"=>"all","preferred_countries"=>["GB"],"exclude_countries"=>[]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_pi_known widget initial_country=GB"
