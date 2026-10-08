#!/usr/bin/env bash
# Reset the "eval-temp-page -> node/1, 302" execution eval to a clean baseline between
# runs so each condition is independent: delete every redirect entity whose source path
# is `eval-temp-page`, then rebuild caches. Mirrors redirect-reset.sh for a distinct source.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  foreach ($storage->loadByProperties(["redirect_source__path" => "eval-temp-page"]) as $r) { $r->delete(); }
  // Belt-and-suspenders: also catch any stragglers via getSourcePathWithQuery().
  foreach ($storage->loadMultiple() as $r) {
    if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-temp-page") { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: redirects for source 'eval-temp-page' deleted, caches rebuilt"
