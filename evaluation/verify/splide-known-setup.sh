#!/usr/bin/env bash
# Introspection SETUP: create a Splide optionset spl_known (type loop, perPage 4, skin seagreen) so an
# agent can read back its configured values. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\splide\Entity\Splide;
  if ($e = Splide::load("spl_known")) { $e->delete(); }
  Splide::create(["id"=>"spl_known","name"=>"spl_known","label"=>"SPL Known","skin"=>"seagreen","group"=>"","options"=>["settings"=>["type"=>"loop","perPage"=>4,"autoplay"=>FALSE]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: splide.optionset.spl_known type=loop perPage=4 skin=seagreen"
