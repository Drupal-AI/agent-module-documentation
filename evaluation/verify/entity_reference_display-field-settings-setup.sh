#!/usr/bin/env bash
# Introspection SETUP: add a KNOWN entity_reference_display ("Display mode") field to
# node.blog_post so an inspecting agent can read its storage type + field settings back.
# The field field_erd_probe is created with type entity_reference_display, cardinality 1,
# and settings exclude=['full'] with negate=FALSE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_erd_probe")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_erd_probe", "entity_type" => "node",
      "type" => "entity_reference_display", "cardinality" => 1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "blog_post", "field_erd_probe")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_erd_probe", "entity_type" => "node", "bundle" => "blog_post",
      "label" => "Display mode",
      "settings" => ["exclude" => ["full" => "full"], "negate" => FALSE],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.blog_post.field_erd_probe (entity_reference_display) added, exclude=[full] negate=FALSE"
