#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("blocache_tagtask")) { $b->delete(); }
  Block::create(["id"=>"blocache_tagtask","theme"=>"olivero","region"=>"content","plugin"=>"system_powered_by_block","settings"=>["id"=>"system_powered_by_block","label"=>"Blocache Tag Task","label_display"=>"0"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block blocache_tagtask present with no blocache override"
