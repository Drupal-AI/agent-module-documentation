#!/usr/bin/env bash
# Introspection SETUP: create a string_micon field field_micon_val on Article and an Article
# node 'Micon Medium Node' whose field stores the icon selector fa-heart, so an agent can read
# the stored icon value back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldStorageConfig::loadByName("node", "field_micon_val")) {
    FieldStorageConfig::create(["field_name"=>"field_micon_val","entity_type"=>"node","type"=>"string_micon"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_micon_val")) {
    FieldConfig::create(["field_name"=>"field_micon_val","entity_type"=>"node","bundle"=>"article","label"=>"Node Icon"])->save();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"Micon Medium Node"]);
  if (!$existing) {
    Node::create(["type"=>"article","title"=>"Micon Medium Node","field_micon_val"=>"fa-heart"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Article node 'Micon Medium Node' field_micon_val = fa-heart"
