#!/usr/bin/env bash
# Introspection SETUP: define Type Tray categories and put the namespaced content type tt_demo
# into one of them, so the agent must read the live config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("tt_demo")) {
    try { NodeType::create(["type" => "tt_demo", "name" => "TT Demo"])->save(); }
    catch (\Throwable $e) { /* unrelated modules may throw in node-type insert hooks */ }
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\NodeType;
  \Drupal::configFactory()->getEditable("type_tray.settings")
    ->set("categories", ["tt_editorial" => "Editorial", "tt_marketing" => "Marketing"])
    ->set("fallback_label", "Uncategorized")
    ->set("text_format", "plain_text")
    ->save();
  if ($t = NodeType::load("tt_demo")) {
    $t->setThirdPartySetting("type_tray", "type_category", "tt_marketing");
    $t->setThirdPartySetting("type_tray", "type_weight", 5);
    try { $t->save(); } catch (\Throwable $e) { }
  }
' >/dev/null 2>&1
echo "setup: type_tray categories tt_editorial|tt_marketing; node type tt_demo -> tt_marketing (weight 5)"
