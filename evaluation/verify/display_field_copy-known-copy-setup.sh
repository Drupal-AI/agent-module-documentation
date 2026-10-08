#!/usr/bin/env bash
# Introspection SETUP: create a Display Suite dynamic field copy (display_field_copy) named
# dfc_known that copies the Article body field, so an inspecting agent can read back the
# source field from the ds.field.* config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ds.field.dfc_known")->setData([
    "id" => "dfc_known",
    "label" => "Body (copy)",
    "ui_limit" => "",
    "properties" => ["field_id" => "node.article.body"],
    "type" => "display_field_copy",
    "type_label" => "Copy field",
    "entities" => ["node" => "node"],
  ])->save();
  \Drupal::service("cache_tags.invalidator")->invalidateTags(["ds_fields_info"]);
' >/dev/null 2>&1
echo "setup: ds.field.dfc_known (display_field_copy) copies node.article.body"
