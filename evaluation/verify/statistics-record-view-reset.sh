#!/usr/bin/env bash
# Execution RESET for "record a view for a node via the Statistics storage service". Creates a
# KNOWN target node ("Statistics Hard Record Target") and clears any node_counter row for it, so
# its total view count starts at zero and verify FAILS until the agent records a view. Removes
# any prior node of that title first. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["title" => "Statistics Hard Record Target"]) as $old) {
    \Drupal::database()->delete("node_counter")->condition("nid", $old->id())->execute();
    $old->delete();
  }
  $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "Statistics Hard Record Target"]);
  $node->save();
  \Drupal::database()->delete("node_counter")->condition("nid", $node->id())->execute();
  print "nid=" . $node->id() . " counter=cleared\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "reset: node 'Statistics Hard Record Target' created with no recorded views"
