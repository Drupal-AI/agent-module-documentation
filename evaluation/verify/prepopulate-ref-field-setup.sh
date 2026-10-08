#!/usr/bin/env bash
# Introspection SETUP: add an entity-reference field field_prepop_ref (autocomplete widget) to
# Article and create a target node, so the agent must inspect the live site to work out the
# prepopulate query string for it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldStorageConfig::loadByName("node", "field_prepop_ref")) {
    FieldStorageConfig::create([
      "field_name" => "field_prepop_ref", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "node"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_prepop_ref")) {
    FieldConfig::create([
      "field_name" => "field_prepop_ref", "entity_type" => "node", "bundle" => "article",
      "label" => "Related campaign",
      "settings" => ["handler" => "default:node", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_prepop_ref", [
    "type" => "entity_reference_autocomplete", "weight" => 60, "region" => "content",
  ])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "Prepopulate Eval Target")->execute();
  if (!$ids) {
    Node::create(["type" => "article", "title" => "Prepopulate Eval Target", "status" => 1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article has field_prepop_ref (entity_reference_autocomplete -> node)"
exit 0
