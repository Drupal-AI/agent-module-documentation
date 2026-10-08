#!/usr/bin/env bash
# Execution VERIFY: PASS when node type menu_force_lock has BOTH menu_force AND
# menu_force_parent === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("menu_force_lock");
  $mf = $t ? $t->getThirdPartySetting("menu_force", "menu_force", NULL) : NULL;
  $mp = $t ? $t->getThirdPartySetting("menu_force", "menu_force_parent", NULL) : NULL;
  $tt = fn($x) => ($x === TRUE || $x === 1 || $x === "1");
  $ok = $tt($mf) && $tt($mp);
  print ($ok ? "PASS" : "FAIL") . " menu_force=" . var_export($mf, TRUE) . " menu_force_parent=" . var_export($mp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
