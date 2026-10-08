#!/usr/bin/env bash
# Introspection SETUP: configure Block List Override to remove a known block (exact match) so an
# agent can read back which block id is targeted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_list_override.settings")
    ->set("system_match", "system_powered_by_block")
    ->set("system_prefix", "")
    ->set("system_regex", "")
    ->set("system_negate", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_list_override.settings system_match='system_powered_by_block' (Remove)"
