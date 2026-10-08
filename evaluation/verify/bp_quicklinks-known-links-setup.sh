#!/usr/bin/env bash
# Introspection SETUP for bp_quicklinks: attach a Paragraphs field field_bpquick_links to
# node.article restricted to the bp_quicklinks bundle, and create the article
# "BP Quicklinks Eval Node" holding one Quicklinks paragraph with a KNOWN bp_width value
# (paragraph--width--narrow), a known header and three quick links. The agent must read the
# live paragraph to report the stored width. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;

  if (!FieldStorageConfig::loadByName("node", "field_bpquick_links")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpquick_links", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpquick_links")) {
    FieldConfig::create([
      "field_name" => "field_bpquick_links", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Quicklinks Sections",
      "settings" => [
        "handler" => "default:paragraph",
        "handler_settings" => ["target_bundles" => ["bp_quicklinks" => "bp_quicklinks"]],
      ],
    ])->save();
  }

  // Remove any previous eval node so the setup is repeatable.
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Quicklinks Eval Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }

  $p = Paragraph::create([
    "type" => "bp_quicklinks",
    "bp_header" => "Helpful Resources",
    "bp_width" => "paragraph--width--narrow",
    "bp_background" => "paragraph--color paragraph--color--info",
    "bp_quick_link" => [
      ["uri" => "internal:/node", "title" => "All content"],
      ["uri" => "https://www.drupal.org", "title" => "Drupal.org"],
      ["uri" => "https://www.drupal.org/project/bootstrap_paragraphs", "title" => "Bootstrap Paragraphs"],
    ],
  ]);
  $p->save();

  Node::create([
    "type" => "article", "title" => "BP Quicklinks Eval Node", "status" => 1,
    "field_bpquick_links" => [$p],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node 'BP Quicklinks Eval Node' has a bp_quicklinks paragraph with bp_width=paragraph--width--narrow and 3 links"
