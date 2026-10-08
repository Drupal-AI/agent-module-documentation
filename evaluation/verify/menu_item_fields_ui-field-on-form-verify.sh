#!/usr/bin/env bash
# Execution VERIFY: PASS when the menu_link_content default form display has a field_miu_desc
# component. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("menu_link_content.menu_link_content.default");
  if (!$fd) { print "FAIL no default form display\n"; return; }
  $c = $fd->getComponent("field_miu_desc");
  print (($c) ? "PASS" : "FAIL") . " component=" . ($c ? ($c["type"] ?? "set") : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
