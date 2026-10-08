#!/usr/bin/env bash
# Introspection SETUP: create a block_styles config entity for block id 'bstyleknown' with the Clean
# Wrapper style (block__clean) and CSS classes 'bstyles-highlight', so an inspecting agent can read
# the theme/classes back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  $e = $s->load("bstyleknown") ?: $s->create(["id"=>"bstyleknown"]);
  $e->set("theme","block__clean"); $e->set("classes","bstyles-highlight"); $e->set("text","");
  $e->save();
' >/dev/null 2>&1
echo "setup: block_styles.blocks.bstyleknown -> theme=block__clean classes=bstyles-highlight"
