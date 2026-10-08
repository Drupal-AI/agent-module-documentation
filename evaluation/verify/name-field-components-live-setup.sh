#!/usr/bin/env bash
# Introspection SETUP: create content type name_ctm and a Name field field_name_ctm on it with
# ONLY the given + family components enabled (title/middle/generational/credentials disabled),
# so the agent must inspect the live field config to report the enabled components. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("name_ctm")) {
    NodeType::create(["type" => "name_ctm", "name" => "Name CT Medium"])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_name_ctm")) {
    FieldStorageConfig::create(["field_name" => "field_name_ctm", "entity_type" => "node", "type" => "name"])->save();
  }
  if (!FieldConfig::loadByName("node", "name_ctm", "field_name_ctm")) {
    FieldConfig::create(["field_name" => "field_name_ctm", "entity_type" => "node", "bundle" => "name_ctm", "label" => "Full name"])->save();
  }
  $fc = FieldConfig::loadByName("node", "name_ctm", "field_name_ctm");
  $settings = $fc->getSettings();
  $settings["components"] = [
    "title" => FALSE, "given" => TRUE, "middle" => FALSE,
    "family" => TRUE, "generational" => FALSE, "credentials" => FALSE,
  ];
  $fc->setSettings($settings)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.name_ctm field_name_ctm components given+family only"
