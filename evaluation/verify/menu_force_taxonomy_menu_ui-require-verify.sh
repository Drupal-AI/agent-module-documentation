#!/usr/bin/env bash
# Execution VERIFY: PASS when vocabulary mfx_task has
# third_party_settings.menu_force_taxonomy_menu_ui.menu_force_taxonomy_menu_ui === TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("mfx_task");
  $x = $v ? $v->getThirdPartySetting("menu_force_taxonomy_menu_ui", "menu_force_taxonomy_menu_ui", NULL) : NULL;
  $ok = ($x === TRUE || $x === 1 || $x === "1");
  print ($ok ? "PASS" : "FAIL") . " menu_force_taxonomy_menu_ui=" . var_export($x, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
