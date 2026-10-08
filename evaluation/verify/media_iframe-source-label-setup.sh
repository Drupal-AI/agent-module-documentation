#!/usr/bin/env bash
# Introspection SETUP: create media type "mi_lblprobe" (inline_frame source) with a source
# field whose label is the module default "Inline Frame URL". Agent reads back that label.
# Uses namespaced storage field_mi_lbl. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $tid="mi_lblprobe"; $fn="field_mi_lbl";
  if (!MediaType::load($tid)) { MediaType::create(["id"=>$tid,"label"=>"MI Label Probe","source"=>"inline_frame"])->save(); }
  if (!FieldStorageConfig::loadByName("media",$fn)) { FieldStorageConfig::create(["entity_type"=>"media","field_name"=>$fn,"type"=>"iframe"])->save(); }
  if (!FieldConfig::loadByName("media",$tid,$fn)) { FieldConfig::create(["entity_type"=>"media","field_name"=>$fn,"bundle"=>$tid,"label"=>"Inline Frame URL","required"=>TRUE])->save(); }
  MediaType::load($tid)->set("source_configuration",["source_field"=>$fn])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mi_lblprobe source field field_mi_lbl label='Inline Frame URL'"
