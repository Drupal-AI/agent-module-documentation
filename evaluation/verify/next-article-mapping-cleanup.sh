#!/usr/bin/env bash
# next introspection CLEANUP: delete next_entity_type_config node.article + next_site nextzz_m2.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextSite;
  use Drupal\next\Entity\NextEntityTypeConfig;
  if ($c = NextEntityTypeConfig::load("node.article")) { $c->delete(); }
  if ($s = NextSite::load("nextzz_m2")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article mapping + nextzz_m2 removed"
