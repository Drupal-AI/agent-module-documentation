#!/usr/bin/env bash
# Execution CLEANUP: delete the namespaced content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("saveedit_task")) { $t->delete(); }
  $c = \Drupal::configFactory()->getEditable("save_edit.settings");
  $nt = $c->get("node_types") ?: [];
  unset($nt["saveedit_task"]);
  $c->set("node_types", $nt)->save();
' >/dev/null 2>&1
echo "cleanup: content type saveedit_task removed"
