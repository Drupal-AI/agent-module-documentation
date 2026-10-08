#!/usr/bin/env bash
# Introspection SETUP: content type tocjspn_def with per-node override on and default DISABLED.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tocjspn_def")) { NodeType::create(["type"=>"tocjspn_def","name"=>"TOCJSPN Def"])->save(); }
  $t = NodeType::load("tocjspn_def");
  $t->setThirdPartySetting("toc_js","toc_js_active",TRUE);
  $t->setThirdPartySetting("toc_js_per_node","override",TRUE);
  $t->setThirdPartySetting("toc_js_per_node","override_default",FALSE);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tocjspn_def override_default=FALSE (disabled)"
