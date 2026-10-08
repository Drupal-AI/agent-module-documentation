#!/usr/bin/env bash
# Introspection SETUP: enable onlyone_admin_toolbar, create content type onlyone_atb_eval and
# restrict it via onlyone.settings, so the toolbar will annotate that type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en onlyone_admin_toolbar -y >/dev/null 2>&1
drush php:eval '
  if (!\Drupal\node\Entity\NodeType::load("onlyone_atb_eval")) {
    \Drupal\node\Entity\NodeType::create(["type"=>"onlyone_atb_eval","name"=>"OnlyOne ATB Eval"])->save();
  }
  $cfg = \Drupal::configFactory()->getEditable("onlyone.settings");
  $types = $cfg->get("onlyone_node_types") ?: [];
  if (!in_array("onlyone_atb_eval",$types,true)) { $types[] = "onlyone_atb_eval"; }
  $cfg->set("onlyone_node_types", array_values($types))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: onlyone_admin_toolbar enabled; onlyone_atb_eval restricted"
