#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'glb inline demo' node(s).
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\Node; foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"glb inline demo"]) as $n) { $n->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'glb inline demo' removed"
