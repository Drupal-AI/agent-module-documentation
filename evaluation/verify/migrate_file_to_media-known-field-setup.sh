#!/usr/bin/env bash
# Introspection SETUP: create a namespaced content type mf2m_kt (with default displays) holding an
# image field field_mf2m_known, then run migrate_file_to_media's field generator so a media
# reference field field_mf2m_known_media is created. An inspecting agent reports the generated
# field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityFormDisplay;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if (!NodeType::load("mf2m_kt")) { NodeType::create(["type"=>"mf2m_kt","name"=>"MF2M Known Type"])->save(); }
  if (!EntityFormDisplay::load("node.mf2m_kt.default")) { EntityFormDisplay::create(["targetEntityType"=>"node","bundle"=>"mf2m_kt","mode"=>"default","status"=>TRUE])->save(); }
  if (!EntityViewDisplay::load("node.mf2m_kt.default")) { EntityViewDisplay::create(["targetEntityType"=>"node","bundle"=>"mf2m_kt","mode"=>"default","status"=>TRUE])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_mf2m_known")) { FieldStorageConfig::create(["field_name"=>"field_mf2m_known","entity_type"=>"node","type"=>"image"])->save(); }
  if (!FieldConfig::loadByName("node","mf2m_kt","field_mf2m_known")) { FieldConfig::create(["field_name"=>"field_mf2m_known","entity_type"=>"node","bundle"=>"mf2m_kt","label"=>"Known Image"])->save(); }
' >/dev/null 2>&1
drush migrate:file-media-fields node mf2m_kt image image >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mf2m_kt has field_mf2m_known (image) and generated field_mf2m_known_media"
