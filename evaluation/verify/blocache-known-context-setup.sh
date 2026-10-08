#!/usr/bin/env bash
# Introspection SETUP: create block blocache_ctx with a blocache override adding the 'url.path' cache
# context. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("blocache_ctx")) { $b->delete(); }
  $b = Block::create(["id"=>"blocache_ctx","theme"=>"olivero","region"=>"content","plugin"=>"system_powered_by_block","settings"=>["id"=>"system_powered_by_block","label"=>"Blocache Ctx","label_display"=>"0"]]);
  $b->setThirdPartySetting("blocache","overridden",TRUE);
  $b->setThirdPartySetting("blocache","metadata",["max-age"=>-1,"contexts"=>["url.path"],"tags"=>[]]);
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block blocache_ctx overrides cache context url.path"
