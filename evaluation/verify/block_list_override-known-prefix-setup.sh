#!/usr/bin/env bash
# Introspection SETUP: configure Block List Override to remove all blocks with a known prefix, so
# an agent can read back the configured prefix. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_list_override.settings")
    ->set("system_match", "")
    ->set("system_prefix", "views_block")
    ->set("system_regex", "")
    ->set("system_negate", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_list_override.settings system_prefix='views_block' (Remove)"
