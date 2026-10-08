#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("salesforce_mapping");
  if ($m = $s->load("sfl_med")) { $m->delete(); }
  $s->create([
    "id" => "sfl_med", "label" => "sfl_med", "weight" => 0, "type" => "salesforce_mapping", "key" => "",
    "async" => TRUE, "always_upsert" => FALSE,
    "salesforce_object_type" => "Contact", "drupal_entity_type" => "user", "drupal_bundle" => "user",
    "sync_triggers" => ["push_create"=>FALSE,"push_update"=>FALSE,"push_delete"=>FALSE,"pull_create"=>TRUE,"pull_update"=>FALSE,"pull_delete"=>FALSE],
    "field_mappings" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: mapping sfl_med with pull_create enabled"
