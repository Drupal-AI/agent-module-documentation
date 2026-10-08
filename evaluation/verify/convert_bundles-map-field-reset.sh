#!/usr/bin/env bash
# Execution RESET for "convert a node from convbnd2_from to convbnd2_to, mapping its
# field_convbnd_src value onto the target's field_convbnd_dst field".
# Creates two namespaced content types, a string field on each (src on source bundle, dst on
# target bundle), deletes any prior test node, and creates node "CB Hard Two" of convbnd2_from
# with field_convbnd_src = "mango". Verify FAILS until bundle==convbnd2_to AND dst=="mango".
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["convbnd2_from" => "CB2 From", "convbnd2_to" => "CB2 To"] as $id => $name) {
    if (!NodeType::load($id)) { NodeType::create(["type" => $id, "name" => $name])->save(); }
  }
  foreach (["field_convbnd_src", "field_convbnd_dst"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "string"])->save();
    }
  }
  if (!FieldConfig::loadByName("node", "convbnd2_from", "field_convbnd_src")) {
    FieldConfig::create(["field_name" => "field_convbnd_src", "entity_type" => "node", "bundle" => "convbnd2_from", "label" => "Source note"])->save();
  }
  if (!FieldConfig::loadByName("node", "convbnd2_to", "field_convbnd_dst")) {
    FieldConfig::create(["field_name" => "field_convbnd_dst", "entity_type" => "node", "bundle" => "convbnd2_to", "label" => "Dest note"])->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "CB Hard Two"]) as $n) { $n->delete(); }
  Node::create(["type" => "convbnd2_from", "title" => "CB Hard Two", "field_convbnd_src" => "mango"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node \"CB Hard Two\" (convbnd2_from, field_convbnd_src=mango); target convbnd2_to/field_convbnd_dst"
