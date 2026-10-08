#!/usr/bin/env bash
# Execution CLEANUP: delete the lsc_demo content type (removes LB display + section). Baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "lsc_demo"]) as $n) { $n->delete(); }
  if ($t = NodeType::load("lsc_demo")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: lsc_demo content type removed"
