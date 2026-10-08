#!/usr/bin/env bash
# Execution RESET: ensure an Article node "NK Alias Node" exists with alias_keeper=0 so verify
# FAILS until the agent locks the alias. Requires Pathauto (adds the alias_keeper field). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $nodes = $s->loadByProperties(["title" => "NK Alias Node"]);
  $n = $nodes ? reset($nodes) : Node::create(["type" => "article", "title" => "NK Alias Node"]);
  if ($n->hasField("alias_keeper")) { $n->set("alias_keeper", FALSE); }
  $n->save();
' >/dev/null 2>&1
echo "reset: Article 'NK Alias Node' present, alias_keeper=0"
