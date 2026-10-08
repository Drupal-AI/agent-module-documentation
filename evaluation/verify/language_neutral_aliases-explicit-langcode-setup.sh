#!/usr/bin/env bash
# Introspection SETUP: create an alias for /lna-src-b explicitly requesting langcode 'en';
# NeutralPathAliasStorage overrides it to und. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\path_alias\Entity\PathAlias;
  $s = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($s->loadByProperties(["path" => "/lna-src-b"]) as $e) { $e->delete(); }
  PathAlias::create(["path" => "/lna-src-b", "alias" => "/lna-alias-b", "langcode" => "en"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: alias /lna-src-b created requesting en (module forces und)"
