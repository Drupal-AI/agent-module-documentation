#!/usr/bin/env bash
# Execution VERIFY: PASS when the block plugin manager has the derived definition
# simple_block:sb_hero. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.block");
  $m->clearCachedDefinitions();
  $ok = $m->hasDefinition("simple_block:sb_hero");
  print ($ok ? "PASS" : "FAIL") . " simple_block:sb_hero=" . ($ok ? "present" : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
