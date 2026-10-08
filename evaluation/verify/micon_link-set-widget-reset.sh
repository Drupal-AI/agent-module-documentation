#!/usr/bin/env bash
# Execution RESET: ensure link field field_micon_link_task exists on Article using the PLAIN
# core link widget (link_default), so verify FAILs until switched to micon_link. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_micon_link_task")) {
    FieldStorageConfig::create(["field_name"=>"field_micon_link_task","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_micon_link_task")) {
    FieldConfig::create(["field_name"=>"field_micon_link_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Link"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_micon_link_task", ["type"=>"link_default","weight"=>53,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_micon_link_task widget=link_default (plain)"
