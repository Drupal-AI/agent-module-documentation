#!/usr/bin/env bash
# Execution RESET: ensure field field_fd_over on Article with Default value NEW_DEFAULT, and a
# namespaced Article node (title 'field_defaults_hard2') whose field_fd_over currently holds a
# DIFFERENT non-empty value OLD_VALUE. verify FAILS until the agent OVERWRITES it with the
# default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldStorageConfig::loadByName("node","field_fd_over")) {
    FieldStorageConfig::create(["field_name"=>"field_fd_over","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fd_over")) {
    FieldConfig::create(["field_name"=>"field_fd_over","entity_type"=>"node","bundle"=>"article","label"=>"FD Over"])->save();
  }
  FieldConfig::loadByName("node","article","field_fd_over")->setDefaultValue([["value"=>"NEW_DEFAULT"]])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","field_defaults_hard2")->execute();
  foreach ($ids as $id) { if ($n = Node::load($id)) { $n->delete(); } }
  Node::create(["type"=>"article","title"=>"field_defaults_hard2","field_fd_over"=>"OLD_VALUE"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fd_over default=NEW_DEFAULT; node field_defaults_hard2 field_fd_over=OLD_VALUE"
