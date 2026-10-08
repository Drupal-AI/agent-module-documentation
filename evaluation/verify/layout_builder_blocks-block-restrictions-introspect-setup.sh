#!/usr/bin/env bash
# MEDIUM introspection setup: write a known layout_builder_blocks.styles config that
# restricts the Style tab to a single block (system_powered_by_block). The agent must read
# this back off the live site. Cleanup deletes the config to restore baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_blocks.styles")
    ->set("block_restrictions", ["system_powered_by_block"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_builder_blocks.styles block_restrictions = [system_powered_by_block]"
