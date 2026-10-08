#!/usr/bin/env bash
# Execution RESET: ensure users ruc_from + ruc_target exist and the article 'RUC Sample' is
# authored by ruc_from (NOT ruc_target), so verify FAILS until reassigned. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  use Drupal\node\Entity\Node;
  $mk = function($name){
    $u = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => $name]);
    if ($u) { return reset($u); }
    $u = User::create(["name" => $name, "mail" => $name."@example.test", "status" => 1]); $u->save(); return $u;
  };
  $from = $mk("ruc_from"); $mk("ruc_target");
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RUC Sample"]);
  $node = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "RUC Sample"]);
  $node->setOwnerId($from->id());
  $node->save();
' >/dev/null 2>&1
echo "reset: RUC Sample authored by ruc_from; ruc_target exists"
