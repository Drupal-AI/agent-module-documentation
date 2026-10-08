#!/usr/bin/env bash
# Introspection CLEANUP: delete the namespaced content type (its bundle_delete hook also removes
# it from save_edit.settings.node_types). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("saveedit_probe")) { $t->delete(); }
  $c = \Drupal::configFactory()->getEditable("save_edit.settings");
  $nt = $c->get("node_types") ?: [];
  unset($nt["saveedit_probe"]);
  $c->set("node_types", $nt)->save();
' >/dev/null 2>&1
echo "cleanup: content type saveedit_probe removed"
