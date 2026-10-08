#!/usr/bin/env bash
# Execution RESET: clear all Block List Override patterns so system_powered_by_block is present ->
# verify FAILS until the agent removes it VIA A REGEX. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("block_list_override.settings");
  foreach (["system_match","system_prefix","system_regex","layout_match","layout_prefix","layout_regex"] as $k) { $c->set($k, ""); }
  $c->set("system_negate", FALSE)->set("layout_negate", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block_list_override.settings cleared (system_powered_by_block present)"
