#!/usr/bin/env bash
# Execution RESET: create storage type rhs_hide + one entity with rh_action=display_page, so
# verify FAILS until the agent changes it to page_not_found. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("rhs_hide")) { StorageType::create(["id"=>"rhs_hide","label"=>"RHS Hide"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_hide")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  $s->create(["type"=>"rhs_hide","name"=>"Hide Me","rh_action"=>"display_page"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rhs_hide entity has rh_action=display_page"
