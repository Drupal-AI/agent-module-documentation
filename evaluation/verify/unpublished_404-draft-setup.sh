#!/usr/bin/env bash
# Introspection SETUP: create one unpublished Article with a distinctive title so an agent can find it
# via drush and confirm it is unpublished. Idempotent (removes any prior copy first).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "u404 medium draft"]) as $n) { $n->delete(); }
  Node::create(["type" => "article", "title" => "u404 medium draft", "status" => 0])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: unpublished Article 'u404 medium draft' created"
