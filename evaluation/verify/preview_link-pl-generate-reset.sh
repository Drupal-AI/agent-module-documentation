#!/usr/bin/env bash
# Execution RESET: ensure an Article node titled 'PL Hard Target' exists and has NO preview
# links, so verify FAILS until the agent generates one.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","article")->condition("title","PL Hard Target")->execute();
  if (!$ids) {
    $n = Node::create(["type"=>"article","title"=>"PL Hard Target","status"=>0]);
    $n->save();
    $nid = $n->id();
  } else {
    $nid = reset($ids);
  }
  // delete any preview links referencing this node
  $pls = \Drupal::entityTypeManager()->getStorage("preview_link")->getQuery()
    ->accessCheck(FALSE)->condition("entities.target_type","node")->condition("entities.target_id",$nid)->execute();
  if ($pls) { $s=\Drupal::entityTypeManager()->getStorage("preview_link"); $s->delete($s->loadMultiple($pls)); }
  print "nid=$nid\n";
' >/dev/null 2>&1
echo "reset: Article 'PL Hard Target' exists with no preview links"
