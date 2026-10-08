#!/usr/bin/env bash
# Execution RESET: ensure a phone_international field field_pi_task exists on Article with its
# widget default (initial) country set to the module default PT, so verify (which wants GB)
# FAILS until the agent changes it. Creates the field if missing (no delete). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pi_task")) {
    FieldStorageConfig::create(["field_name"=>"field_pi_task","entity_type"=>"node","type"=>"phone_international"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pi_task")) {
    FieldConfig::create(["field_name"=>"field_pi_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Phone"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pi_task", [
    "type" => "phone_international_widget", "weight" => 50, "region" => "content",
    "settings" => ["initial_country"=>"PT","geolocation"=>FALSE,"countries"=>"exclude","preferred_countries"=>["PT"],"exclude_countries"=>[]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_pi_task widget initial_country=PT"
