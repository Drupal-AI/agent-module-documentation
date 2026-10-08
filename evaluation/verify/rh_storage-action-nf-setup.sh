#!/usr/bin/env bash
# Introspection SETUP: create storage type rhs_nf + one entity whose rh_action is
# page_not_found. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("rhs_nf")) { StorageType::create(["id"=>"rhs_nf","label"=>"RHS NF"])->save(); }
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_nf")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  $s->create(["type"=>"rhs_nf","name"=>"Hidden Record","rh_action"=>"page_not_found"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: storage entity of type rhs_nf has rh_action=page_not_found"
