#!/usr/bin/env bash
# Introspection SETUP: create a block_styles config entity for block 'bsboot_known' using the
# block_styles_bootstrap 'Bootstrap Card' style, so an agent can read back the applied style id. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bsboot_known")) { $e->delete(); }
  $s->create(["id"=>"bsboot_known","theme"=>"block__bootstrap__card","classes"=>"","text"=>""])->save();
' >/dev/null 2>&1
echo "setup: block_styles.blocks.bsboot_known -> theme=block__bootstrap__card"
