#!/usr/bin/env bash
# Introspection SETUP: create simple_block sb_known with a known title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  if (!SimpleBlock::load("sb_known")) {
    SimpleBlock::create(["id" => "sb_known", "title" => "SB Known Title", "content" => ["value" => "<p>SB Known Title content</p>", "format" => "plain_text"]])->save();
  }
' >/dev/null 2>&1
echo "ready: simple_block sb_known present"
