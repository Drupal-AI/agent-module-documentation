#!/usr/bin/env bash
# Introspection SETUP for bp_webform: create webform bpwf_status_form, attach field_bpwf_gate
# to node.article (restricted to bp_webform) and create the article "BP Webform Status Node"
# whose Webform paragraph stores the per-reference status column as "closed". This exercises
# the fact that the webform field item carries its own target_id/status/open/close/default_data
# columns, so one embed can be closed while the same webform stays open elsewhere.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Webform Status Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("bpwf_status_form")) {
    Webform::create([
      "id" => "bpwf_status_form",
      "title" => "BP Webform Status Form",
      "elements" => "email:\n  \x27#type\x27: email\n  \x27#title\x27: Email\n",
    ])->save();
  }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpwf_gate")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpwf_gate", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpwf_gate")) {
    FieldConfig::create([
      "field_name" => "field_bpwf_gate", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Webform Gate",
      "settings" => [
        "handler" => "default:paragraph",
        "handler_settings" => ["target_bundles" => ["bp_webform" => "bp_webform"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  $p = Paragraph::create([
    "type" => "bp_webform",
    "bp_background" => "paragraph--color paragraph--color--warning",
    "bp_webform" => [["target_id" => "bpwf_status_form", "status" => "closed"]],
  ]);
  $p->save();
  Node::create([
    "type" => "article", "title" => "BP Webform Status Node", "status" => 1,
    "field_bpwf_gate" => [$p],
  ])->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "setup: 'BP Webform Status Node' bp_webform paragraph stores bp_webform status=closed"
