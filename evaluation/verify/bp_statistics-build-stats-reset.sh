#!/usr/bin/env bash
# Execution RESET for bp_statistics "build a nested Statistics band": ensure the Paragraphs
# field field_bpstat_task exists on node.article (restricted to bp_statistics) and delete any
# node titled "BP Statistics Task" plus its paragraphs, so the matching verify FAILS on empty
# state. Never touches the shipped bp_statistics / bp_stat paragraph types. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Statistics Task")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpstat_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpstat_task", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpstat_task")) {
    FieldConfig::create([
      "field_name" => "field_bpstat_task", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Statistics Task Band",
      "settings" => [
        "handler" => "default:paragraph",
        "handler_settings" => ["target_bundles" => ["bp_statistics" => "bp_statistics"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "reset: field_bpstat_task ready on node.article, node 'BP Statistics Task' absent"
