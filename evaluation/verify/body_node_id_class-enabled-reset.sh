#!/usr/bin/env bash
# Execution RESET: uninstall body_node_id_class (so node pages get NO nid/type body class) and
# ensure a published Article node 'BNIC Home Node' exists. verify FAILS until the agent
# re-enables the module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu body_node_id_class -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "BNIC Home Node"]);
  if (!$existing) {
    Node::create(["type" => "article", "title" => "BNIC Home Node", "status" => 1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: body_node_id_class uninstalled; Article node 'BNIC Home Node' present"
