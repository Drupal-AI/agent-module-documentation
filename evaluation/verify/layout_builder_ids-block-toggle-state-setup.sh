#!/usr/bin/env bash
# Introspection SETUP: block_id=0, section_id=1. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_builder_ids.settings")->set("block_id",0)->set("section_id",1)->save();' >/dev/null 2>&1
echo "setup: layout_builder_ids block_id=0, section_id=1"
