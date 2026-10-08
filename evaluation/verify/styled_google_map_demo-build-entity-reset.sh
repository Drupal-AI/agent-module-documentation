#!/usr/bin/env bash
# Execution RESET: delete any real_estate entity named 'SGM Task Estate' so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\styled_google_map_demo\Entity\RealEstate;
  $ids = \Drupal::entityQuery("real_estate")->accessCheck(FALSE)->condition("name","SGM Task Estate")->execute();
  foreach ($ids as $id) { if ($e = RealEstate::load($id)) { $e->delete(); } }
' >/dev/null 2>&1
echo "reset: no real_estate entity named 'SGM Task Estate'"
