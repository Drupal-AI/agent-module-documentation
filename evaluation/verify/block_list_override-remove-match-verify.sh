#!/usr/bin/env bash
# Execution VERIFY: PASS when system_powered_by_block is no longer in the block plugin list AND
# it is configured in system_match. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.block");
  $m->clearCachedDefinitions();
  $defs = $m->getDefinitions();
  $gone = !isset($defs["system_powered_by_block"]);
  $match = (string) (\Drupal::config("block_list_override.settings")->get("system_match") ?? "");
  $inmatch = strpos($match, "system_powered_by_block") !== FALSE;
  $ok = $gone && $inmatch;
  print ($ok ? "PASS" : "FAIL") . " gone=" . var_export($gone, TRUE) . " in_match=" . var_export($inmatch, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
