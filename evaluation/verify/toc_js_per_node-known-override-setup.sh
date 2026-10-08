#!/usr/bin/env bash
# Introspection SETUP: content type tocjspn_doc with Toc.js on and per-node override enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tocjspn_doc")) { NodeType::create(["type"=>"tocjspn_doc","name"=>"TOCJSPN Doc"])->save(); }
  $t = NodeType::load("tocjspn_doc");
  $t->setThirdPartySetting("toc_js","toc_js_active",TRUE);
  $t->setThirdPartySetting("toc_js_per_node","override",TRUE);
  $t->setThirdPartySetting("toc_js_per_node","override_default",FALSE);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tocjspn_doc override=TRUE override_default=FALSE"
