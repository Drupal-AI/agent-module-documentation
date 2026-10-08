#!/usr/bin/env bash
# Execution RESET for bp_quicklinks "build a Quicklinks paragraph on a node": ensure the
# Paragraphs field field_bpquick_menu exists on node.article (restricted to bp_quicklinks)
# and delete any node titled "BP Quicklinks Task" plus its paragraphs, so the matching
# verify FAILS on empty state. Never touches the shipped bp_quicklinks paragraph type.
# Idempotent. Exit 0.
#
# Node deletion and field creation run as SEPARATE drush calls on purpose so a failure in
# one cannot skip the other.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Quicklinks Task")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpquick_menu")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpquick_menu", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpquick_menu")) {
    FieldConfig::create([
      "field_name" => "field_bpquick_menu", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Quicklinks Menu",
      "settings" => [
        "handler" => "default:paragraph",
        "handler_settings" => ["target_bundles" => ["bp_quicklinks" => "bp_quicklinks"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "reset: field_bpquick_menu ready on node.article, node 'BP Quicklinks Task' absent"
