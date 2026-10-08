#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\styled_google_map_demo\Entity\RealEstate;
  $ids = \Drupal::entityQuery("real_estate")->accessCheck(FALSE)->condition("name","SGMD Sacramento Home")->execute();
  foreach ($ids as $id) { if ($e = RealEstate::load($id)) { $e->delete(); } }
' >/dev/null 2>&1
echo "cleanup: real_estate entity 'SGMD Sacramento Home' removed"
