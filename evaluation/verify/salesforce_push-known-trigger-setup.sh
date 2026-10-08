#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("salesforce_mapping");
  if ($m = $s->load("sfp_med")) { $m->delete(); }
  $s->create([
    "id" => "sfp_med", "label" => "sfp_med", "weight" => 0, "type" => "salesforce_mapping", "key" => "",
    "async" => TRUE, "always_upsert" => FALSE,
    "salesforce_object_type" => "Contact", "drupal_entity_type" => "user", "drupal_bundle" => "user",
    "sync_triggers" => ["push_create"=>TRUE,"push_update"=>TRUE,"push_delete"=>FALSE,"pull_create"=>FALSE,"pull_update"=>FALSE,"pull_delete"=>FALSE],
    "push_limit" => 0, "field_mappings" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: mapping sfp_med with push_update enabled"
