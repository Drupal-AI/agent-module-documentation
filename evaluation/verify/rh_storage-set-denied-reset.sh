#!/usr/bin/env bash
# Execution RESET: create storage type rhs_task + one entity 'Task Record' with rh_action set
# to display_page, so verify FAILS until the agent changes it to access_denied. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("rhs_task")) { StorageType::create(["id"=>"rhs_task","label"=>"RHS Task"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_task")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  $s->create(["type"=>"rhs_task","name"=>"Task Record","rh_action"=>"display_page"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rhs_task entity has rh_action=display_page"
