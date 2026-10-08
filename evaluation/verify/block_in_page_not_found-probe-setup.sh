#!/usr/bin/env bash
# Introspection SETUP: create a block bipnf_probe in the olivero theme whose visibility uses the
# page_not_found_request condition with page_not_found=TRUE, so an agent can read back that the
# block is restricted to 404 pages. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("bipnf_probe")) { $b->delete(); }
  Block::create([
    "id" => "bipnf_probe", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block", "weight" => 0,
    "settings" => ["id"=>"system_powered_by_block","label"=>"BIPNF Probe","label_display"=>"0","provider"=>"system"],
    "visibility" => ["page_not_found_request" => ["id"=>"page_not_found_request","page_not_found"=>TRUE,"negate"=>FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block bipnf_probe restricted to 404 via page_not_found_request (page_not_found=true)"
