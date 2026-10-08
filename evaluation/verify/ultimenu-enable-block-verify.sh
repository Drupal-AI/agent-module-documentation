#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'content' menu is enabled as an Ultimenu block, i.e.
# ultimenu.settings blocks.content is non-empty AND the derivative block plugin
# ultimenu_block:ultimenu-content is available. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::config("ultimenu.settings")->get("blocks") ?: [];
  $cfg = !empty($blocks["content"]);
  $has = \Drupal::service("plugin.manager.block")->hasDefinition("ultimenu_block:ultimenu-content");
  $ok = $cfg && $has;
  print ($ok ? "PASS" : "FAIL") . " blocks.content=" . var_export($blocks["content"] ?? NULL, TRUE) . " derivative=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
