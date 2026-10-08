#!/usr/bin/env bash
# Execution RESET for bp_webform "embed a webform in a page": ensure the webform
# bpwf_task_form and the Paragraphs field field_bpwf_slot (restricted to bp_webform) exist,
# and delete any node titled "BP Webform Task" plus its paragraphs, so the matching verify
# FAILS on empty state. Never touches the shipped bp_webform paragraph type. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Webform Task")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("bpwf_task_form")) {
    Webform::create([
      "id" => "bpwf_task_form",
      "title" => "BP Webform Task Form",
      "elements" => "message:\n  \x27#type\x27: textarea\n  \x27#title\x27: Message\n",
    ])->save();
  }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpwf_slot")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpwf_slot", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpwf_slot")) {
    FieldConfig::create([
      "field_name" => "field_bpwf_slot", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Webform Task Slot",
      "settings" => [
        "handler" => "default:paragraph",
        "handler_settings" => ["target_bundles" => ["bp_webform" => "bp_webform"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "reset: webform bpwf_task_form + field_bpwf_slot ready, node 'BP Webform Task' absent"
