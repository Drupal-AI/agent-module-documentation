#!/usr/bin/env bash
# Introspection SETUP: insert a known row into the migrate_file_to_media_mapping table so an agent
# can inspect it and report the recorded migration_id. Idempotent (clears prior probe rows).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("migrate_file_to_media_mapping")->condition("migration_id","mf2m_probe_mapping")->execute();
  $db->insert("migrate_file_to_media_mapping")->fields([
    "migration_id"=>"mf2m_probe_mapping","type"=>"file","fid"=>4242,"target_fid"=>4242,"binary_hash"=>"deadbeefmf2mprobehash",
  ])->execute();
' >/dev/null 2>&1
echo "setup: migrate_file_to_media_mapping row migration_id=mf2m_probe_mapping inserted"
