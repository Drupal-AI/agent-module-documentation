#!/usr/bin/env bash
# Introspection SETUP: create a fresh media type (lm_probe, File source) through the entity
# API so Lightning Media's hook_ENTITY_TYPE_insert() fires and attaches its own field to it.
# The agent must inspect the live field configuration for that bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("lm_probe")) {
    $type = MediaType::create([
      "id" => "lm_probe",
      "label" => "LM Probe",
      "source" => "file",
    ]);
    $type->save();
    $field = $type->getSource()->createSourceField($type);
    $field->getFieldStorageDefinition()->save();
    $field->save();
    $type->set("source_configuration", ["source_field" => $field->getName()])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type lm_probe created (File source)"
