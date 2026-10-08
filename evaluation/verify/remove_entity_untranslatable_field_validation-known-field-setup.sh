#!/usr/bin/env bash
# Introspection SETUP: install a known config - a content type ruftv_med with an UNtranslatable
# string field field_ruftv_med, translation enabled - so an agent can read back which field is
# untranslatable (and, thanks to this module, still editable from any translation). Idempotent.
# Does NOT run 'drush cr'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("ruftv_med")) NodeType::create(["type"=>"ruftv_med","name"=>"RUFTV Med"])->save();
  \Drupal::service("content_translation.manager")->setEnabled("node","ruftv_med",TRUE);
  if (!FieldStorageConfig::loadByName("node","field_ruftv_med")) FieldStorageConfig::create(["field_name"=>"field_ruftv_med","entity_type"=>"node","type"=>"string"])->save();
  if (!FieldConfig::loadByName("node","ruftv_med","field_ruftv_med")) FieldConfig::create(["field_name"=>"field_ruftv_med","entity_type"=>"node","bundle"=>"ruftv_med","label"=>"Shared code","translatable"=>FALSE])->save();
' >/dev/null 2>&1
echo "setup: node.ruftv_med with untranslatable field field_ruftv_med (translation enabled)"
