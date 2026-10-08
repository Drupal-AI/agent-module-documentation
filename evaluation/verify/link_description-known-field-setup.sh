#!/usr/bin/env bash
# Introspection SETUP: create a link_description field field_ld_known on Article (with a value on a
# node) so an inspecting agent can read back which Article field uses the link_description type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldStorageConfig::loadByName("node", "field_ld_known")) {
    FieldStorageConfig::create(["field_name" => "field_ld_known", "entity_type" => "node", "type" => "link_description", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ld_known")) {
    FieldConfig::create(["field_name" => "field_ld_known", "entity_type" => "node", "bundle" => "article", "label" => "Known LD Links", "settings" => ["title" => 1, "link_type" => 0x11]])->save();
  }
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "article", "title" => "LD Known Node"]);
  if (!$ns) {
    Node::create(["type" => "article", "title" => "LD Known Node", "status" => 1, "field_ld_known" => [["uri" => "https://example.com", "title" => "Example", "description" => "LD known description"]]])->save();
  }
' >/dev/null 2>&1
echo "setup: node.article field_ld_known (type link_description) present"
