#!/usr/bin/env bash
# Execution CLEANUP: remove the eval node + alias and restore the shipped subpathauto defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/subpathauto-eval"]) as $a) { $a->delete(); }
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "Subpathauto Eval Page")->execute();
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
  \Drupal::configFactory()->getEditable("subpathauto.settings")
    ->set("depth", 0)->set("redirect_support", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: eval node+alias removed, subpathauto.settings restored to depth=0 redirect_support=TRUE"
