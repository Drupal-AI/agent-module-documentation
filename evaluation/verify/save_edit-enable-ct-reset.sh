#!/usr/bin/env bash
# Execution RESET: ensure a namespaced content type exists with Save & Edit DISABLED, so verify
# fails until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("saveedit_task")) {
    NodeType::create(["type" => "saveedit_task", "name" => "Save Edit Task"])->save();
  }
  $c = \Drupal::configFactory()->getEditable("save_edit.settings");
  $nt = $c->get("node_types") ?: [];
  $nt["saveedit_task"] = "0";
  $c->set("node_types", $nt)->save();
' >/dev/null 2>&1
echo "reset: content type saveedit_task present, Save & Edit disabled (node_types=0)"
