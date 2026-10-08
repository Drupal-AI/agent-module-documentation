#!/usr/bin/env bash
# HARD execution RESET: ensure hierarchy field field_eh_tree exists on Article, and create two
# Article nodes (titles EH Parent Node / EH Child Node) with the child NOT yet parented. verify
# FAILs until the agent sets the child's field_eh_tree to reference the parent. Storage is
# created in its own process first (see known-field-setup for why). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eh_tree")) {
    FieldStorageConfig::create([
      "field_name" => "field_eh_tree", "entity_type" => "node",
      "type" => "entity_reference_hierarchy", "cardinality" => 1,
      "settings" => ["target_type" => "node"],
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldConfig::loadByName("node", "article", "field_eh_tree")) {
    FieldConfig::create([
      "field_name" => "field_eh_tree", "entity_type" => "node", "bundle" => "article",
      "label" => "Tree parent",
      "settings" => ["handler" => "default:node", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
    ])->save();
  }
  foreach (["EH Parent Node", "EH Child Node"] as $title) {
    $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $title]);
    foreach ($existing as $n) { $n->delete(); }
  }
  Node::create(["type" => "article", "title" => "EH Parent Node", "status" => 1])->save();
  Node::create(["type" => "article", "title" => "EH Child Node", "status" => 1])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eh_tree present; EH Parent Node + EH Child Node created, child unparented"
