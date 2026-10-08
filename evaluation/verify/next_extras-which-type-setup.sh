#!/usr/bin/env bash
# next_extras introspection SETUP: node.article revalidate=TRUE, node.page revalidate=FALSE.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextEntityTypeConfig;
  foreach (["node.article" => TRUE, "node.page" => FALSE] as $id => $rv) {
    if ($c = NextEntityTypeConfig::load($id)) { $c->delete(); }
    $c = NextEntityTypeConfig::create(["id" => $id, "site_resolver" => "site_selector", "configuration" => ["sites" => []]]);
    $c->setThirdPartySetting("next_extras", "revalidate", $rv);
    $c->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article revalidate=TRUE, node.page revalidate=FALSE"
