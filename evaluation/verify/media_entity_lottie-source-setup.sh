#!/usr/bin/env bash
# Introspection SETUP: create a media type 'mel_src' using the lottie_file source (auto-creates a
# json-only source field), so an agent can read back the source plugin + allowed extension. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mel_src")) {
    $t = MediaType::create(["id"=>"mel_src","label"=>"MEL Source","source"=>"lottie_file"]);
    $t->save();
    $field = $t->getSource()->createSourceField($t);
    $fsc = $field->getFieldStorageDefinition();
    if ($fsc->isNew()) { $fsc->save(); }
    if ($field->isNew()) { $field->save(); }
    $t->set("source_configuration", ["source_field"=>$field->getName()])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mel_src (source lottie_file, json source field) created"
