#!/usr/bin/env bash
# Execution VERIFY: PASS when vocabulary mfx_lock has BOTH menu_force_taxonomy_menu_ui AND
# menu_force_taxonomy_menu_ui_parent === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("mfx_lock");
  $mf = $v ? $v->getThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", NULL) : NULL;
  $mp = $v ? $v->getThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui_parent", NULL) : NULL;
  $tt = fn($x) => ($x === TRUE || $x === 1 || $x === "1");
  $ok = $tt($mf) && $tt($mp);
  print ($ok ? "PASS" : "FAIL") . " menu_force_taxonomy_menu_ui=" . var_export($mf, TRUE) . " parent=" . var_export($mp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
