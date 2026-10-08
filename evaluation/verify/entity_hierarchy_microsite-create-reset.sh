#!/usr/bin/env bash
# HARD execution RESET: ensure submodule enabled, remove any "EHM Task Site" microsite, and
# create a home node "EHM Task Home" the agent can point a new microsite at. verify FAILs until
# the agent creates the microsite. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_hierarchy_microsite -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("entity_hierarchy_microsite")->loadByProperties(["name" => "EHM Task Site"]) as $ms) { $ms->delete(); }
  $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "EHM Task Home"]);
  if (!$existing) { Node::create(["type" => "article", "title" => "EHM Task Home", "status" => 1])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no 'EHM Task Site' microsite; home node 'EHM Task Home' present"
