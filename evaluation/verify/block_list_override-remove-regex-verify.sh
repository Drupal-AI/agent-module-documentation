#!/usr/bin/env bash
# Execution VERIFY: PASS when system_powered_by_block is removed from the block plugin list AND a
# non-empty regex pattern is configured in system_regex (enforces the regex mechanism).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.block");
  $m->clearCachedDefinitions();
  $defs = $m->getDefinitions();
  $gone = !isset($defs["system_powered_by_block"]);
  $regex = trim((string) (\Drupal::config("block_list_override.settings")->get("system_regex") ?? ""));
  $has_regex = $regex !== "";
  $ok = $gone && $has_regex;
  print ($ok ? "PASS" : "FAIL") . " gone=" . var_export($gone, TRUE) . " regex=" . var_export($regex, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
