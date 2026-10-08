#!/usr/bin/env bash
# Introspection SETUP: create simple_block sb_known2 (its block derivative is simple_block:sb_known2). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  if (!SimpleBlock::load("sb_known2")) {
    SimpleBlock::create(["id" => "sb_known2", "title" => "SB Known Two", "content" => ["value" => "<p>SB Known Two content</p>", "format" => "plain_text"]])->save();
  }
' >/dev/null 2>&1
echo "ready: simple_block sb_known2 present"
