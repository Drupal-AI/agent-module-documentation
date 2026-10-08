#!/usr/bin/env bash
# Execution RESET: ensure a namespaced text field field_fd_task exists on Article with the
# configured Default value TASK_DEFAULT, and a namespaced Article node (title
# 'field_defaults_hard1') whose field_fd_task value is EMPTY. So verify FAILS until the agent
# applies the default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldStorageConfig::loadByName("node","field_fd_task")) {
    FieldStorageConfig::create(["field_name"=>"field_fd_task","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_fd_task")) {
    FieldConfig::create(["field_name"=>"field_fd_task","entity_type"=>"node","bundle"=>"article","label"=>"FD Task"])->save();
  }
  FieldConfig::loadByName("node","article","field_fd_task")->setDefaultValue([["value"=>"TASK_DEFAULT"]])->save();
  // Recreate the test node with an EMPTY field value.
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","field_defaults_hard1")->execute();
  foreach ($ids as $id) { if ($n = Node::load($id)) { $n->delete(); } }
  Node::create(["type"=>"article","title"=>"field_defaults_hard1","field_fd_task"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_fd_task default=TASK_DEFAULT; node field_defaults_hard1 has EMPTY field_fd_task"
