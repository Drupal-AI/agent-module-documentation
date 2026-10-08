#!/usr/bin/env bash
# Introspection SETUP: create then edit an Article title (new revision, empty log) so
# revision_log_default fills "Updated the Title field" on the latest revision.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RLD Known Update EDITED"]) as $e) { $e->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RLD Known Update"]) as $e) { $e->delete(); }
  $n = Node::create(["type" => "article", "title" => "RLD Known Update"]);
  $n->save();
  $n->setTitle("RLD Known Update EDITED");
  $n->setNewRevision(TRUE);
  $n->setRevisionLogMessage("");
  $n->save();
  print "latest_msg=" . $n->getRevisionLogMessage() . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: node 'RLD Known Update EDITED' has an auto update revision message"
