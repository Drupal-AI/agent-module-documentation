#!/usr/bin/env bash
# Execution VERIFY: PASS when block nmr_task exists, uses a navigation_menu_role plugin, and
# its settings.roles restricts to the content_editor role. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("nmr_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $roles = $b ? ($b->get("settings")["roles"] ?? []) : [];
  $ok = ($b && strpos($plugin, "navigation_menu_role:") === 0 && in_array("content_editor", (array) $roles, TRUE));
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " roles=" . implode("|", (array) $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
