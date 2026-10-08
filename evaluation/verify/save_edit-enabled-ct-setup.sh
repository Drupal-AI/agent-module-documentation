#!/usr/bin/env bash
# Introspection SETUP: create a namespaced content type and enable Save & Edit on it, so the
# agent can read node_types config and report which content type has the button. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("saveedit_probe")) {
    NodeType::create(["type" => "saveedit_probe", "name" => "Save Edit Probe"])->save();
  }
  $c = \Drupal::configFactory()->getEditable("save_edit.settings");
  $nt = $c->get("node_types") ?: [];
  $nt["saveedit_probe"] = "saveedit_probe";
  $c->set("node_types", $nt)->save();
' >/dev/null 2>&1
echo "setup: content type saveedit_probe created and enabled in save_edit.settings.node_types"
