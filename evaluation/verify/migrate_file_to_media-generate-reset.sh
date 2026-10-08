#!/usr/bin/env bash
# Execution RESET: ensure content type mf2m_ht (with default displays) holds an image field
# field_mf2m_task but NO generated field_mf2m_task_media, so verify FAILS until the agent runs the
# migrate_file_to_media field generator. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityFormDisplay;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if (!NodeType::load("mf2m_ht")) { NodeType::create(["type"=>"mf2m_ht","name"=>"MF2M Hard Type"])->save(); }
  if (!EntityFormDisplay::load("node.mf2m_ht.default")) { EntityFormDisplay::create(["targetEntityType"=>"node","bundle"=>"mf2m_ht","mode"=>"default","status"=>TRUE])->save(); }
  if (!EntityViewDisplay::load("node.mf2m_ht.default")) { EntityViewDisplay::create(["targetEntityType"=>"node","bundle"=>"mf2m_ht","mode"=>"default","status"=>TRUE])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_mf2m_task")) { FieldStorageConfig::create(["field_name"=>"field_mf2m_task","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","mf2m_ht","field_mf2m_task")) { FieldConfig::create(["field_name"=>"field_mf2m_task","entity_type"=>"node","bundle"=>"mf2m_ht","label"=>"Task Image"])->save(); }
  if ($fc = FieldConfig::loadByName("node","mf2m_ht","field_mf2m_task_media")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_mf2m_task_media")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mf2m_ht has field_mf2m_task (image), field_mf2m_task_media absent"
