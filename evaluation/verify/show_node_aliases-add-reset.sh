#!/usr/bin/env bash
# Execution RESET: ensure a fresh Article node titled sna_task_node exists with NO
# /sna-task-promo alias (so verify FAILS until the agent adds that alias). Removes any prior
# copy and stray alias. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("title", "sna_task_node")->execute();
  foreach ($ids as $nid) {
    foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path" => "/node/" . $nid]) as $pa) { $pa->delete(); }
    if ($n = Node::load($nid)) { $n->delete(); }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/sna-task-promo"]) as $pa) { $pa->delete(); }
  $n = Node::create(["type" => "article", "title" => "sna_task_node"]); $n->save();
  print "nid=" . $n->id() . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "reset: node sna_task_node present with no /sna-task-promo alias"
