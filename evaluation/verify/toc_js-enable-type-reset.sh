#!/usr/bin/env bash
# Execution RESET: create content type tocjs_page with Toc.js DISABLED and no toc_js extra field, so
# verify FAILS until the agent enables the TOC and places the toc_js extra field on the default view
# display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tocjs_page")) { NodeType::create(["type"=>"tocjs_page","name"=>"TOCJS Page"])->save(); }
  $t = NodeType::load("tocjs_page");
  $t->setThirdPartySetting("toc_js","toc_js_active",FALSE);
  $t->save();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.tocjs_page.default");
  if ($vd && $vd->getComponent("toc_js")) { $vd->removeComponent("toc_js")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content type tocjs_page present, Toc.js disabled, no toc_js field"
