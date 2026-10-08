#!/usr/bin/env bash
# Introspection SETUP: create a known real_estate entity so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\styled_google_map_demo\Entity\RealEstate;
  $ids = \Drupal::entityQuery("real_estate")->accessCheck(FALSE)->condition("name","SGM Demo Villa 42")->execute();
  if (!$ids) {
    RealEstate::create(["name"=>"SGM Demo Villa 42","price"=>123456,"status"=>1])->save();
  }
' >/dev/null 2>&1
echo "setup: real_estate entity name='SGM Demo Villa 42' price=123456 created"
