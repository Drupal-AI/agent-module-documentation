#!/usr/bin/env bash
# Execution RESET: (re)create wcc_edit with edit-synchronization OFF (sync_content=false), so
# verify FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("webform_content_creator");
  if ($e = $s->load("wcc_edit")) { $e->delete(); }
  $s->create([
    "id"=>"wcc_edit","title"=>"Editable mapping",
    "webform"=>"contact","target_entity_type"=>"node","target_bundle"=>"article",
    "sync_content"=>FALSE,"sync_content_delete"=>FALSE,"sync_unique"=>FALSE,"use_encrypt"=>FALSE,
    "redirect_to_entity"=>FALSE,
    "elements"=>["title"=>["type"=>FALSE,"webform_field"=>"","custom_check"=>TRUE,"custom_value"=>"Test","mapping"=>"default_mapping"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: wcc_edit created with sync_content=false"
