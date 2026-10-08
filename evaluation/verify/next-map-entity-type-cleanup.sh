#!/usr/bin/env bash
# next execution CLEANUP: delete next_entity_type_config node.page and next_site nextzz_map.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextSite;
  use Drupal\next\Entity\NextEntityTypeConfig;
  if ($c = NextEntityTypeConfig::load("node.page")) { $c->delete(); }
  if ($s = NextSite::load("nextzz_map")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.page mapping + nextzz_map removed"
