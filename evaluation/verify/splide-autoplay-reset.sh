#!/usr/bin/env bash
# Execution RESET: create Splide optionset spl_edit with autoplay OFF, so verify FAILS until the agent
# enables autoplay on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\splide\Entity\Splide;
  if ($e = Splide::load("spl_edit")) { $e->delete(); }
  Splide::create(["id"=>"spl_edit","name"=>"spl_edit","label"=>"SPL Edit","skin"=>"default","group"=>"","options"=>["settings"=>["type"=>"slide","perPage"=>1,"autoplay"=>FALSE]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: optionset spl_edit created with autoplay OFF"
