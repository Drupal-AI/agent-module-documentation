#!/usr/bin/env bash
# Introspection SETUP: create a known webform_content_creator config entity wcc_known that maps the
# 'contact' webform to node/article, with edit-synchronization ON, so an inspecting agent can read
# the mapping back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("webform_content_creator");
  if (!$s->load("wcc_known")) {
    $s->create([
      "id"=>"wcc_known","title"=>"Contact to Article",
      "webform"=>"contact","target_entity_type"=>"node","target_bundle"=>"article",
      "sync_content"=>TRUE,"sync_content_delete"=>FALSE,"sync_unique"=>FALSE,"use_encrypt"=>FALSE,
      "redirect_to_entity"=>FALSE,
      "elements"=>["title"=>["type"=>FALSE,"webform_field"=>"","custom_check"=>TRUE,"custom_value"=>"[webform_submission:values:subject]","mapping"=>"default_mapping"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: wcc_known (webform=contact -> node/article, sync_content=true)"
