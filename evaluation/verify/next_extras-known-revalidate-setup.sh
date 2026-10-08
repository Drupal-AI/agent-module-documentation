#!/usr/bin/env bash
# next_extras setup: create next_entity_type_config node.article with next_extras.revalidate=TRUE paths='/blog'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextEntityTypeConfig;
  if ($c = NextEntityTypeConfig::load("node.article")) { $c->delete(); }
  $c = NextEntityTypeConfig::create(["id" => "node.article", "site_resolver" => "site_selector", "configuration" => ["sites" => []]]);
  $c->setThirdPartySetting("next_extras", "revalidate", TRUE);
  $c->setThirdPartySetting("next_extras", "revalidate_paths", "/blog");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article next_extras.revalidate=TRUE paths=/blog"
