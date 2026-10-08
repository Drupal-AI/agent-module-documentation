#!/usr/bin/env bash
# Execution RESET: ensure content type mf2m_ht2 (with default displays) holds TWO image fields
# field_mf2m_a and field_mf2m_b but NO generated *_media fields, so verify FAILS until the agent
# runs the migrate_file_to_media field generator (which creates a media field per file field).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityFormDisplay;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if (!NodeType::load("mf2m_ht2")) { NodeType::create(["type"=>"mf2m_ht2","name"=>"MF2M Hard Type 2"])->save(); }
  if (!EntityFormDisplay::load("node.mf2m_ht2.default")) { EntityFormDisplay::create(["targetEntityType"=>"node","bundle"=>"mf2m_ht2","mode"=>"default","status"=>TRUE])->save(); }
  if (!EntityViewDisplay::load("node.mf2m_ht2.default")) { EntityViewDisplay::create(["targetEntityType"=>"node","bundle"=>"mf2m_ht2","mode"=>"default","status"=>TRUE])->save(); }
  foreach (["field_mf2m_a","field_mf2m_b"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) { FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"image"])->save(); }
    if (!FieldConfig::loadByName("node","mf2m_ht2",$fn)) { FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"mf2m_ht2","label"=>strtoupper($fn)])->save(); }
    if ($fc = FieldConfig::loadByName("node","mf2m_ht2",$fn."_media")) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn."_media")) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mf2m_ht2 has field_mf2m_a and field_mf2m_b (image), no *_media"
