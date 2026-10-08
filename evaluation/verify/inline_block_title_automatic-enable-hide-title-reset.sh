#!/usr/bin/env bash
# Execution RESET: ibta_h1 present WITHOUT Layout Builder so verify FAILS until enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("ibta_h1")) { $nt->delete(); }
  NodeType::create(["type" => "ibta_h1", "name" => "ibta_h1"])->save();
' >/dev/null 2>&1
echo "reset: node.ibta_h1 present WITHOUT Layout Builder"
