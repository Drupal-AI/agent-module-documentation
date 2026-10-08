#!/usr/bin/env bash
# Execution RESET: ensure Article 'node_class execution target' exists with node_class EMPTY
# (so verify FAILS until the agent sets nc-hero). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $t = "node_class execution target";
  $ids = \Drupal::entityQuery("node")->condition("title", $t)->accessCheck(FALSE)->execute();
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
  Node::create(["type" => "article", "title" => $t, "node_class" => "", "status" => 1])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'node_class execution target' present with empty node_class"
