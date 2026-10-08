#!/usr/bin/env bash
# Introspection SETUP: create content type tocjs_doc with Toc.js enabled and a known title.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tocjs_doc")) { NodeType::create(["type"=>"tocjs_doc","name"=>"TOCJS Doc"])->save(); }
  $t = NodeType::load("tocjs_doc");
  $t->setThirdPartySetting("toc_js","toc_js_active",TRUE);
  $t->setThirdPartySetting("toc_js","title","In this article");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type tocjs_doc has toc_js_active=TRUE, title 'In this article'"
