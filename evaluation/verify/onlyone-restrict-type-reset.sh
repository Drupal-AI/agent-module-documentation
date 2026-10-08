#!/usr/bin/env bash
# Execution RESET: create content type onlyone_task and ensure it is NOT in onlyone_node_types,
# so verify FAILS until the agent restricts it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\node\Entity\NodeType::load("onlyone_task")) {
    \Drupal\node\Entity\NodeType::create(["type"=>"onlyone_task","name"=>"OnlyOne Task"])->save();
  }
  $cfg = \Drupal::configFactory()->getEditable("onlyone.settings");
  $types = array_values(array_filter($cfg->get("onlyone_node_types") ?: [], fn($t) => $t !== "onlyone_task"));
  $cfg->set("onlyone_node_types", $types)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: onlyone_task content type present, NOT restricted"
