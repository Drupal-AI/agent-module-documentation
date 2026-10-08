#!/usr/bin/env bash
# Introspection SETUP: place a block bipnf_neg whose page_not_found_request condition has
# page_not_found=TRUE and negate=TRUE (i.e. shown everywhere EXCEPT the 404 page), so an agent
# can read the negate flag back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("bipnf_neg")) { $b->delete(); }
  Block::create([
    "id" => "bipnf_neg", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block", "weight" => 0,
    "settings" => ["id"=>"system_powered_by_block","label"=>"BIPNF Neg","label_display"=>"0","provider"=>"system"],
    "visibility" => ["page_not_found_request" => ["id"=>"page_not_found_request","page_not_found"=>TRUE,"negate"=>TRUE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block bipnf_neg has page_not_found_request with negate=TRUE"
