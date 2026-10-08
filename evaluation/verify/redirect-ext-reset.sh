#!/usr/bin/env bash
# Reset the "eval-ext -> external URL, 301" execution eval to a clean baseline between
# runs so each condition is independent: delete every redirect entity whose source path
# is `eval-ext`, then rebuild caches. Mirrors redirect-reset.sh for a distinct source.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  foreach ($storage->loadByProperties(["redirect_source__path" => "eval-ext"]) as $r) { $r->delete(); }
  // Belt-and-suspenders: also catch any stragglers via getSourcePathWithQuery().
  foreach ($storage->loadMultiple() as $r) {
    if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-ext") { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: redirects for source 'eval-ext' deleted, caches rebuilt"
