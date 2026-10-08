#!/usr/bin/env bash
# Execution VERIFY: PASS when node type menu_force_task has
# third_party_settings.menu_force.menu_force === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("menu_force_task");
  $v = $t ? $t->getThirdPartySetting("menu_force", "menu_force", NULL) : NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " menu_force=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
