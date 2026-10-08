#!/usr/bin/env bash
# Execution RESET: create a page node with the URL alias /mmp-md-node, and DISABLE the
# markdownify_path submodule so that /mmp-md-node.md does NOT resolve (verify FAILS) until the
# agent enables markdownify_path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","MMP MD Node")->accessCheck(FALSE)->execute();
  if ($ids) { $n = Node::load(reset($ids)); }
  else {
    $n = Node::create(["type"=>"page","title"=>"MMP MD Node","status"=>1,"body"=>["value"=>"<p>Alias markdown <em>body</em>.</p>","format"=>"basic_html"]]);
    $n->save();
  }
  $store = \Drupal::entityTypeManager()->getStorage("path_alias");
  $existing = $store->loadByProperties(["alias"=>"/mmp-md-node"]);
  if (!$existing) { $store->create(["path"=>"/node/".$n->id(),"alias"=>"/mmp-md-node"])->save(); }
' >/dev/null 2>&1
drush pmu markdownify_path -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node with alias /mmp-md-node present; markdownify_path DISABLED"
