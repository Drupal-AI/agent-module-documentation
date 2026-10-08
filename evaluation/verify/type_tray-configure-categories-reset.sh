#!/usr/bin/env bash
# Execution RESET: guarantee the namespaced content type tt_demo exists, wipe its type_tray
# third-party settings and reset type_tray.settings to the shipped baseline, so verify fails
# until the agent configures categories and assigns the type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tt_demo")) {
    try { NodeType::create(["type" => "tt_demo", "name" => "TT Demo"])->save(); }
    catch (\Throwable $e) { }
  }
' >/dev/null 2>&1
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
echo "reset: type_tray.settings has no categories; tt_demo has no type_tray settings"
