#!/usr/bin/env bash
# Execution RESET: ensure a single Article titled 'RLD Hard Update' exists with one revision;
# remove any already-edited copy so verify FAILS until the agent edits + re-saves.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (["RLD Hard Update EDITED","RLD Hard Update"] as $t) {
    foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $t]) as $e) { $e->delete(); }
  }
  $n = Node::create(["type" => "article", "title" => "RLD Hard Update"]);
  $n->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'RLD Hard Update' present with a single (creation) revision"
