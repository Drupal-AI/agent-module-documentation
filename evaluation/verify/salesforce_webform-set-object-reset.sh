#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("salesforce_mapping");
  if ($m = $s->load("sfw_otask")) { $m->delete(); }
  $s->create([
    "id" => "sfw_otask", "label" => "sfw_otask", "weight" => 0, "type" => "salesforce_mapping", "key" => "",
    "salesforce_object_type" => "Lead", "drupal_entity_type" => "webform_submission", "drupal_bundle" => "contact",
    "sync_triggers" => ["push_create"=>TRUE,"push_update"=>FALSE,"push_delete"=>FALSE,"pull_create"=>FALSE,"pull_update"=>FALSE,"pull_delete"=>FALSE],
    "field_mappings" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: mapping sfw_otask -> Lead"
