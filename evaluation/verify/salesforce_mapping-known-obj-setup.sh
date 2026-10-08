#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("salesforce_mapping");
  if ($m = $s->load("sfm_known")) { $m->delete(); }
  $s->create([
    "id" => "sfm_known", "label" => "sfm_known", "weight" => 0, "type" => "salesforce_mapping",
    "key" => "", "async" => TRUE, "always_upsert" => FALSE,
    "salesforce_object_type" => "Contact",
    "drupal_entity_type" => "user", "drupal_bundle" => "user",
    "sync_triggers" => ["push_create"=>TRUE,"push_update"=>TRUE,"push_delete"=>FALSE,"pull_create"=>FALSE,"pull_update"=>FALSE,"pull_delete"=>FALSE],
    "field_mappings" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: mapping sfm_known (Contact <-> user.user) created"
