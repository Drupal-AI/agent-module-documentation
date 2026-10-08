#!/usr/bin/env bash
# Introspection CLEANUP: restore section_id=1, block_id=1. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_builder_ids.settings")->set("section_id",1)->set("block_id",1)->save();' >/dev/null 2>&1
echo "cleanup: layout_builder_ids section_id=1, block_id=1"
