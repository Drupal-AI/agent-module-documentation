#!/usr/bin/env bash
# Execution CLEANUP: clear the two settings written during the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("tt_demo")) {
    $t->unsetThirdPartySetting("type_tray", "existing_nodes_link_text");
    $t->unsetThirdPartySetting("type_tray", "type_icon");
    try { $t->save(); } catch (\Throwable $e) { }
  }
' >/dev/null 2>&1
echo "cleanup: tt_demo existing_nodes_link_text and type_icon cleared"
