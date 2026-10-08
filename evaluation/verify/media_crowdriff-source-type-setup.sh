#!/usr/bin/env bash
# Introspection SETUP: create a media type mc_probe_type whose media source is Media Crowdriff,
# so an inspecting agent can read back which source plugin it uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mc_probe_type")) {
    $t = MediaType::create(["id"=>"mc_probe_type","label"=>"MC Probe Type","source"=>"media_crowdriff"]);
    $t->save();
    $f = $t->getSource()->createSourceField($t);
    $f->getFieldStorageDefinition()->save();
    $f->save();
    $t->set("source_configuration",["source_field"=>$f->getName()])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media type mc_probe_type uses source media_crowdriff (field field_media_media_crowdriff)"
