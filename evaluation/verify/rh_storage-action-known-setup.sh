#!/usr/bin/env bash
# Introspection SETUP: create storage type rhs_known + one storage entity 'Locked Record'
# whose Rabbit Hole action (rh_action) is access_denied, so the agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("rhs_known")) { StorageType::create(["id"=>"rhs_known","label"=>"RHS Known"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_known")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  $s->create(["type"=>"rhs_known","name"=>"Locked Record","rh_action"=>"access_denied"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: storage entity of type rhs_known has rh_action=access_denied"
