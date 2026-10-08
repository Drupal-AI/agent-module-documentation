#!/usr/bin/env bash
# Execution RESET: guarantee tt_demo exists and clear its existing-content link text and icon,
# so verify fails until the agent sets them. Idempotent. Exit 0.
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
    $t->unsetThirdPartySetting("type_tray", "existing_nodes_link_text");
    $t->unsetThirdPartySetting("type_tray", "type_icon");
    try { $t->save(); } catch (\Throwable $e) { }
  }
' >/dev/null 2>&1
echo "reset: tt_demo has no existing_nodes_link_text and no type_icon"
