#!/usr/bin/env bash
# Introspection SETUP: create an Article with no revision log message so revision_log_default
# fills it with "Created new Article". Agent must read the node's revision log message back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RLD Known Created"]) as $e) { $e->delete(); }
  $n = Node::create(["type" => "article", "title" => "RLD Known Created"]);
  $n->save();
  print "msg=" . $n->getRevisionLogMessage() . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: node 'RLD Known Created' created (revision log auto-generated)"
