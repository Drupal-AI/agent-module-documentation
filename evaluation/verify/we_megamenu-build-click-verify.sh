#!/usr/bin/env bash
# Execution VERIFY: PASS when a We Mega Menu layout is stored for we_mm_menu (under the default
# theme) AND its block_config.action === "clicked". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  $cfg = \Drupal\we_megamenu\WeMegaMenuBuilder::loadConfig("we_mm_menu", $theme);
  $action = (is_object($cfg) && isset($cfg->block_config->action)) ? $cfg->block_config->action : NULL;
  $ok = (is_object($cfg) && $action === "clicked");
  print ($ok ? "PASS" : "FAIL") . " stored=" . (is_object($cfg) ? "yes" : "no") . " action=" . var_export($action, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
