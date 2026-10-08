#!/usr/bin/env bash
# Execution RESET: enable onlyone_admin_toolbar, create content type onlyone_atb_task, and make
# sure it is NOT restricted, so verify FAILS until the agent restricts it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en onlyone_admin_toolbar -y >/dev/null 2>&1
drush php:eval '
  if (!\Drupal\node\Entity\NodeType::load("onlyone_atb_task")) {
    \Drupal\node\Entity\NodeType::create(["type"=>"onlyone_atb_task","name"=>"OnlyOne ATB Task"])->save();
  }
  $cfg = \Drupal::configFactory()->getEditable("onlyone.settings");
  $types = array_values(array_filter($cfg->get("onlyone_node_types") ?: [], fn($t) => $t !== "onlyone_atb_task"));
  $cfg->set("onlyone_node_types", $types)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: onlyone_admin_toolbar enabled; onlyone_atb_task present, not restricted"
