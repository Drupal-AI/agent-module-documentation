#!/usr/bin/env bash
# Introspection CLEANUP: delete the known real_estate entity. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\styled_google_map_demo\Entity\RealEstate;
  $ids = \Drupal::entityQuery("real_estate")->accessCheck(FALSE)->condition("name","SGM Demo Villa 42")->execute();
  foreach ($ids as $id) { if ($e = RealEstate::load($id)) { $e->delete(); } }
' >/dev/null 2>&1
echo "cleanup: real_estate entity 'SGM Demo Villa 42' removed"
