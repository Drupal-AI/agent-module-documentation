#!/usr/bin/env bash
# Execution VERIFY: PASS when mes_embed's default view display renders field_mes_eurl with the
# soundcloud_embed formatter set to the 'classic' player type. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("media", "mes_embed", "default");
  $c = $vd->getComponent("field_mes_eurl");
  $type = $c["type"] ?? "none";
  $ptype = $c["settings"]["type"] ?? "none";
  $ok = ($type === "soundcloud_embed" && $ptype === "classic");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " player_type=" . $ptype . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
