#!/usr/bin/env bash
# Introspection SETUP: create user 'ruc_author' and an article 'RUC Known' authored by them so
# an agent can read back the author. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  use Drupal\node\Entity\Node;
  $users = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "ruc_author"]);
  $u = $users ? reset($users) : User::create(["name" => "ruc_author", "mail" => "ruc_author@example.test", "status" => 1]);
  if ($u->isNew()) { $u->save(); }
  if (!\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RUC Known"])) {
    Node::create(["type" => "article", "title" => "RUC Known", "uid" => $u->id()])->save();
  }
' >/dev/null 2>&1
echo "setup: node RUC Known authored by ruc_author"
