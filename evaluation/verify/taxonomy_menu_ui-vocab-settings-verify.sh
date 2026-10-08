#!/usr/bin/env bash
# Execution VERIFY for "restrict the tmui_events vocabulary to the tmui_events_menu menu".
# PASS when taxonomy.vocabulary.tmui_events carries third-party settings under the `menu_ui`
# provider (the name taxonomy_menu_ui reuses) with available_menus == ['tmui_events_menu']
# and parent == 'tmui_events_menu:'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("tmui_events");
  $menus = $v ? $v->getThirdPartySetting("menu_ui", "available_menus", NULL) : NULL;
  $parent = $v ? $v->getThirdPartySetting("menu_ui", "parent", NULL) : NULL;
  $ok = is_array($menus)
    && array_values($menus) === ["tmui_events_menu"]
    && $parent === "tmui_events_menu:";
  print ($ok ? "PASS" : "FAIL")
    . " vocab=" . ($v ? "present" : "missing")
    . " available_menus=" . json_encode($menus)
    . " parent=" . var_export($parent, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
