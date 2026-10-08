#!/usr/bin/env bash
# Introspection SETUP: create a real_estate entity resembling a row the data submodule
# imports from demo.csv, so an agent can read its price. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\styled_google_map_demo\Entity\RealEstate;
  $ids = \Drupal::entityQuery("real_estate")->accessCheck(FALSE)->condition("name","SGMD 3526 HIGH ST")->execute();
  if (!$ids) {
    RealEstate::create(["name"=>"SGMD 3526 HIGH ST","price"=>59222,"status"=>1,"location"=>"POINT (-121.434879 38.631913)"])->save();
  }
' >/dev/null 2>&1
echo "setup: real_estate entity 'SGMD 3526 HIGH ST' price=59222 created"
