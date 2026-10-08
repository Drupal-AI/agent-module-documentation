#!/usr/bin/env bash
# Introspection CLEANUP: delete the ccc_known_user@example.com account, its orders, and ccc_eval_store.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $ids = \Drupal::entityQuery("user")->condition("mail", "ccc_known_user@example.com")->accessCheck(FALSE)->execute();
  foreach (User::loadMultiple($ids) as $u) {
    foreach (\Drupal::entityTypeManager()->getStorage("commerce_order")->loadByProperties(["uid" => $u->id()]) as $o) { $o->delete(); }
    $u->delete();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_store")->loadByProperties(["name" => "ccc_eval_store"]) as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ccc_known_user@example.com, its carts, and ccc_eval_store removed"
