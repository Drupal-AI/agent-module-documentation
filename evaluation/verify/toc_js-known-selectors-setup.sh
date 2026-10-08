#!/usr/bin/env bash
# Introspection SETUP: content type tocjs_sel with Toc.js enabled and custom heading selectors.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tocjs_sel")) { NodeType::create(["type"=>"tocjs_sel","name"=>"TOCJS Sel"])->save(); }
  $t = NodeType::load("tocjs_sel");
  $t->setThirdPartySetting("toc_js","toc_js_active",TRUE);
  $t->setThirdPartySetting("toc_js","selectors","h1,h2,h3");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type tocjs_sel selectors=h1,h2,h3"
