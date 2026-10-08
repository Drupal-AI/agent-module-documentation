#!/usr/bin/env bash
# Introspection CLEANUP: clear tt_demo's type_tray settings and restore the shipped
# type_tray.settings baseline (fallback_label only). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("tt_demo")) {
    foreach (["type_category", "type_weight", "type_thumbnail", "type_icon", "type_description", "existing_nodes_link_text"] as $k) {
      $t->unsetThirdPartySetting("type_tray", $k);
    }
    try { $t->save(); } catch (\Throwable $e) { }
  }
  $c = \Drupal::configFactory()->getEditable("type_tray.settings");
  $c->clear("categories")->clear("text_format")->set("fallback_label", "Uncategorized")->save();
' >/dev/null 2>&1
echo "cleanup: type_tray.settings back to fallback_label only; tt_demo type_tray settings cleared"
