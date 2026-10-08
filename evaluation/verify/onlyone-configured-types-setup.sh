#!/usr/bin/env bash
# Introspection SETUP: create content type onlyone_eval and add it to onlyone.settings
# onlyone_node_types, so an agent can read back which types are restricted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\node\Entity\NodeType::load("onlyone_eval")) {
    \Drupal\node\Entity\NodeType::create(["type"=>"onlyone_eval","name"=>"OnlyOne Eval"])->save();
  }
  $cfg = \Drupal::configFactory()->getEditable("onlyone.settings");
  $types = $cfg->get("onlyone_node_types") ?: [];
  if (!in_array("onlyone_eval",$types,true)) { $types[] = "onlyone_eval"; }
  $cfg->set("onlyone_node_types", array_values($types))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: onlyone_eval content type created and added to onlyone_node_types"
