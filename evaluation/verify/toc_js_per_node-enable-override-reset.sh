#!/usr/bin/env bash
# Execution RESET: content type tocjspn_page with Toc.js ON but per-node override OFF, so verify
# FAILS until the agent enables the per-node override.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tocjspn_page")) { NodeType::create(["type"=>"tocjspn_page","name"=>"TOCJSPN Page"])->save(); }
  $t = NodeType::load("tocjspn_page");
  $t->setThirdPartySetting("toc_js","toc_js_active",TRUE);
  $t->setThirdPartySetting("toc_js_per_node","override",FALSE);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tocjspn_page toc_js on, per-node override off"
