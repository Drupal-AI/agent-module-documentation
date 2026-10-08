#!/usr/bin/env bash
# Execution RESET: create (idempotently) a page node aliased to /subpathauto-eval and then
# DELETE the subpathauto.settings config object. With no 'depth' value the path processor's
# loop never runs, so /subpathauto-eval/edit does NOT resolve and verify fails. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "Subpathauto Eval Page")->execute();
  if (!$ids) {
    $n = Node::create(["type" => "page", "title" => "Subpathauto Eval Page", "status" => 1]);
    $n->save();
  }
  else {
    $n = Node::load(reset($ids));
  }
  $storage = \Drupal::entityTypeManager()->getStorage("path_alias");
  if (!$storage->loadByProperties(["alias" => "/subpathauto-eval"])) {
    $storage->create(["path" => "/node/" . $n->id(), "alias" => "/subpathauto-eval", "langcode" => "en"])->save();
  }
  \Drupal::configFactory()->getEditable("subpathauto.settings")->delete();
  print "nid=" . $n->id() . "\n";
' 2>/dev/null
echo "reset: /subpathauto-eval alias present, subpathauto.settings deleted"
