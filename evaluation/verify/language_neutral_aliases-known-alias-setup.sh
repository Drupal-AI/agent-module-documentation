#!/usr/bin/env bash
# Introspection SETUP: create a path alias for system path /lna-src-a (module forces it neutral).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\path_alias\Entity\PathAlias;
  $s = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($s->loadByProperties(["path" => "/lna-src-a"]) as $e) { $e->delete(); }
  PathAlias::create(["path" => "/lna-src-a", "alias" => "/lna-alias-a"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: path alias /lna-src-a -> /lna-alias-a created (stored neutral)"
