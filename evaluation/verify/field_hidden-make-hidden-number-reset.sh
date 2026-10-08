#!/usr/bin/env bash
# Execution RESET: ensure an integer field field_fh_score exists on Article with the core
# number widget on the default form display, so verify FAILS until the agent switches it to the
# Field Hidden number widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fh_score")) {
    FieldStorageConfig::create(["field_name" => "field_fh_score", "entity_type" => "node", "type" => "integer"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fh_score")) {
    FieldConfig::create(["field_name" => "field_fh_score", "entity_type" => "node", "bundle" => "article", "label" => "Score"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_fh_score", ["type" => "number", "weight" => 53, "region" => "content"])->save();
' >/dev/null 2>&1
echo "reset: node.article field_fh_score present with widget number (NOT hidden)"
