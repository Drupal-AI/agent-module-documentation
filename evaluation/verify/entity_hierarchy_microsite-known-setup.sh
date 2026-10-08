#!/usr/bin/env bash
# MEDIUM introspection SETUP: ensure the submodule is enabled and create a known Microsite
# entity ("EHM Known Site") whose home is a known Article node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_hierarchy_microsite -y >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\entity_hierarchy_microsite\Entity\Microsite;
  $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "EHM Home Node"]);
  $home = $existing ? reset($existing) : NULL;
  if (!$home) { $home = Node::create(["type" => "article", "title" => "EHM Home Node", "status" => 1]); $home->save(); }
  $ms = \Drupal::entityTypeManager()->getStorage("entity_hierarchy_microsite")->loadByProperties(["name" => "EHM Known Site"]);
  if (!$ms) {
    Microsite::create(["name" => "EHM Known Site", "home" => ["target_id" => $home->id()], "generate_menu" => TRUE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Microsite 'EHM Known Site' -> home node 'EHM Home Node'"
