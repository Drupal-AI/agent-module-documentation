#!/usr/bin/env bash
# Introspection SETUP: create media type "mi_probe" whose source is the media_iframe
# "Inline frame" (inline_frame) source, so an inspecting agent can find which media type
# uses that source. Uses a namespaced source field (field_mi_probe, type iframe).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $tid="mi_probe"; $fn="field_mi_probe";
  if (!MediaType::load($tid)) { MediaType::create(["id"=>$tid,"label"=>"MI Probe","source"=>"inline_frame"])->save(); }
  if (!FieldStorageConfig::loadByName("media",$fn)) { FieldStorageConfig::create(["entity_type"=>"media","field_name"=>$fn,"type"=>"iframe"])->save(); }
  if (!FieldConfig::loadByName("media",$tid,$fn)) { FieldConfig::create(["entity_type"=>"media","field_name"=>$fn,"bundle"=>$tid,"label"=>"Inline Frame URL","required"=>TRUE])->save(); }
  MediaType::load($tid)->set("source_configuration",["source_field"=>$fn])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mi_probe uses source inline_frame (source field field_mi_probe)"
