#!/usr/bin/env bash
# Execution RESET: create a block_styles config for block 'bstyletaskb' with the Clean Wrapper style
# but EMPTY classes, so verify FAILs until the agent adds 'bstyles-wide'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bstyletaskb")) { $e->delete(); }
  $s->create(["id"=>"bstyletaskb","theme"=>"block__clean","classes"=>"","text"=>""])->save();
' >/dev/null 2>&1
echo "reset: block_styles.blocks.bstyletaskb theme=block__clean classes=(empty)"
